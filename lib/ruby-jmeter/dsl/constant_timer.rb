module RubyJmeter
  class DSL
    def constant_timer(params={}, &block)
      node = RubyJmeter::ConstantTimer.new(params)
      attach_node(node, &block)
    end
  end

  class ConstantTimer
    attr_accessor :doc
    include Helper

    def initialize(params={})
      testname = params.kind_of?(Array) ? 'ConstantTimer' : (params[:name] || 'ConstantTimer')
      deplay = params.kind_of?(Array) ? '300' : (params[:delay] || '300')

      @doc = Nokogiri::XML(<<-EOS.strip_heredoc)
<ConstantTimer guiclass="ConstantTimerGui" testclass="ConstantTimer" testname="#{testname}" enabled="true">
  <stringProp name="ConstantTimer.delay">#{deplay}</stringProp>
</ConstantTimer>)
      EOS
      update params
      update_at_xpath params if params.is_a?(Hash) && params[:update_at_xpath]
    end
  end

end
