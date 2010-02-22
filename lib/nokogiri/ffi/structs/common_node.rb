module Nokogiri
  module LibXML # :nodoc:
    module CommonNode # :nodoc:
      def document
        p = self[:doc]
        p.null? ? nil : LibXML::XmlDocumentCast.new(p)
      end

      if I_WANT_TO_USE_ID2REF
        def ruby_node_pointer
          self[:_private]
        end

        def ruby_node_pointer=(value)
          self[:_private] = value
        end
      end

      def ruby_node
        LibXML.get_object(self)
      end

      def ruby_node= object
        LibXML.set_object(self, object)
      end

      def keep_reference_from_document! # equivalent to NOKOGIRI_ROOT_NODE
        doc = self.document
        raise "no document to add reference to" unless doc
        LibXML.xmlXPathNodeSetAdd(doc.unlinked_nodes, self)
      end

      def keep_reference_from!(document) # equivalent to NOKOGIRI_ROOT_NSDEF
        raise "no document to add reference to" unless document
        LibXML.xmlXPathNodeSetAdd(document.unlinked_nodes, self)
      end
    end
  end
end

