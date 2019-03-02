class UrlParser
  attr_reader :scheme, :fragment_id, :query_string, :path, :port, :domain#used so we dont have to create a method for all these attributes.
  def initialize(url)

    @scheme = url.split(':/')[0]
    
    unless url.split('#').length == 1      
      @fragment_id = url.split('#')[-1]
      url = url.chomp! '#' + @fragment_id
    end

    unless url.split('?').length == 1
      query = url.split('?')[-1]
      url = url.chomp! '?' + query

      @query_string = {}

      pairs = query.split('&')

      pairs.each do |pair|
        pair =  pair.split('=')
        @query_string[pair[0]] = pair[1]       
      end
    end

    if url.split('/').length > 3
      @path = url.split('/')[-1]
      url.chomp! '/' + @path
    end

    if url.split(':')[-1].length < 6
      @port = url.split(':')[-1]
      url = url.chomp! ':' + @port
    elsif @scheme == 'http'
      @port = '80'
    elsif @scheme == 'https'
      @port = '443'
    end

    @domain = url.split('//')[-1].chomp '/'
  end
end