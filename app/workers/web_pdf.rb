require 'resque/errors'
require 'pp'


# Steps:
#  1. Queue job with url as param
#  2. Fetch source via source id
#  3. Initialize new PDFKit with Source URL
#  4. Generate filename (domain + source uuid) and save kit to file
#  5. Set source file to local file
#  6. Delete local file



module RetriedJob
  def on_failure_retry(e, *args)
    puts "Performing #{self} caused an exception (#{e}). Retrying..."
    $stdout.flush
    Resque.enqueue self, *args
  end
end

class WebPDF
  extend RetriedJob
  
  attr_accessor :source, :pdf
  
  @queue = :pdf_queue
  
  
  # Initialize WebPDF Job
  def initialize(source_id)
    @source = Source.find_by_uuid(source_id)
    @source.update_attributes(status: 'processing')
  end
  
  
  # Perform job, called by Resque
  def self.perform(source_id)
    (new source_id).generate
  rescue Resque::TermException
    Resque.enqueue(self, source_id)
  end
  
  
  # Generate PDF and save
  def generate
    create_pdf
    store_pdf
    destroy_pdf
    @source.update_attributes(status: 'ready')
  end
  
  
  private
  
  # Store File to Fog, set to carrierwave
  def store_pdf
    puts "WebPDF: Storing #{file_path}"
    @source.update_attributes(document: @pdf)
  end
  
  # Create a PDF from URL
  def create_pdf
    puts "WebPDF: Creating #{file_path}"
    begin
      kit = PDFKit.new(@source.uri)
      @pdf = kit.to_file(file_path)
    rescue => e
      @pdf = File.open(file_path)
    end
  end
  
  # Destroy PDF
  def destroy_pdf
    puts "WebPDF: Destroying temp #{file_path}"
    @pdf.close
    File.delete(@pdf)
  end
  
  # File Path
  def file_path
    File.join(temp_base, file_name)
  end
  
  # Make the file name
  def file_name
    "#{@source.domain}_#{@source.uuid}.pdf"
  end
  
  # Temp file path base
  def temp_base
    File.join(Rails.root, "tmp")
  end
  
end