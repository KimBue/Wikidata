module Wikidata


    using HTTP, JSON

    struct WikidataEntity
        code::String
        dataDict::Dict
    end

    function WikidataEntity(name::String)
        resp = HTTP.get("https://www.wikidata.org/wiki/Special:EntityData/$(name).json")
        #resp = HTTP.request("get", "www.google.com")
        str = String(resp.body)
        jobj = JSON.Parser.parse(str)["entities"][name]
        #descriptions = jobj["descriptions"]
        WikidataEntity(name, jobj)
    end

    function label(x::WikidataEntity)
    x.dataDict["labels"]["en"]["value"]
end
    function hasproperty(x::WikidataEntity, property::String)
        return haskey(x.dataDict["claims"], property)
end

end # module
