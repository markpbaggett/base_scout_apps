(:~

    Transformation module generated from TEI ODD extensions for processing models.
    ODD: /db/apps/scout/resources/odd/tei_simplePrint.odd
 :)
xquery version "3.1";

module namespace model="http://www.tei-c.org/pm/models/tei_simplePrint/web";

declare default element namespace "http://www.tei-c.org/ns/1.0";

declare namespace xhtml='http://www.w3.org/1999/xhtml';

declare namespace xi='http://www.w3.org/2001/XInclude';

import module namespace css="http://www.tei-c.org/tei-simple/xquery/css";

import module namespace html="http://www.tei-c.org/tei-simple/xquery/functions";

(:~

    Main entry point for the transformation.
    
 :)
declare function model:transform($options as map(*), $input as node()*) {
        
    let $config :=
        map:merge(($options,
            map {
                "output": ["web"],
                "odd": "/db/apps/scout/resources/odd/tei_simplePrint.odd",
                "apply": model:apply#2,
                "apply-children": model:apply-children#3
            }
        ))
    
    return (
        html:prepare($config, $input),
    
        let $output := model:apply($config, $input)
        return
            html:finish($config, $output)
    )
};

declare function model:apply($config as map(*), $input as node()*) {
        let $parameters := 
        if (exists($config?parameters)) then $config?parameters else map {}
        let $get := 
        model:source($parameters, ?)
    return
    $input !         (
            let $node := 
                .
            return
                            typeswitch(.)
                    case element(ab) return
                        html:paragraph($config, ., ("tei-ab"), .)
                    case element(abbr) return
                        html:inline($config, ., ("tei-abbr"), .)
                    case element(actor) return
                        html:inline($config, ., ("tei-actor"), .)
                    case element(add) return
                        html:inline($config, ., ("tei-add"), .)
                    case element(address) return
                        html:block($config, ., ("tei-address"), .)
                    case element(addrLine) return
                        html:block($config, ., ("tei-addrLine"), .)
                    case element(am) return
                        html:inline($config, ., ("tei-am"), .)
                    case element(anchor) return
                        html:anchor($config, ., ("tei-anchor"), ., @xml:id)
                    case element(argument) return
                        html:block($config, ., ("tei-argument"), .)
                    case element(author) return
                        if (ancestor::teiHeader) then
                            html:omit($config, ., ("tei-author1"), .)
                        else
                            html:inline($config, ., ("tei-author2"), .)
                    case element(back) return
                        html:block($config, ., ("tei-back"), .)
                    case element(bibl) return
                        if (parent::listBibl) then
                            html:listItem($config, ., ("tei-bibl1"), ., ())
                        else
                            html:inline($config, ., ("tei-bibl2"), .)
                    case element(biblScope) return
                        html:inline($config, ., ("tei-biblScope"), .)
                    case element(body) return
                        (
                            html:index($config, ., ("tei-body1"), 'toc', .),
                            html:block($config, ., ("tei-body2"), .)
                        )

                    case element(byline) return
                        html:block($config, ., ("tei-byline"), .)
                    case element(c) return
                        html:inline($config, ., ("tei-c"), .)
                    case element(castGroup) return
                        if (child::*) then
                            (: Insert list. :)
                            html:list($config, ., ("tei-castGroup"), castItem|castGroup, ())
                        else
                            $config?apply($config, ./node())
                    case element(castItem) return
                        (: Insert item, rendered as described in parent list rendition. :)
                        html:listItem($config, ., ("tei-castItem"), ., ())
                    case element(castList) return
                        if (child::*) then
                            html:list($config, ., css:get-rendition(., ("tei-castList")), castItem, ())
                        else
                            $config?apply($config, ./node())
                    case element(cb) return
                        html:break($config, ., ("tei-cb"), ., 'column', @n)
                    case element(cell) return
                        (: Insert table cell. :)
                        html:cell($config, ., ("tei-cell"), ., ())
                    case element(choice) return
                        if (sic and corr) then
                            html:alternate($config, ., ("tei-choice4"), ., corr[1], sic[1], map {})
                        else
                            if (abbr and expan) then
                                html:alternate($config, ., ("tei-choice5"), ., expan[1], abbr[1], map {})
                            else
                                if (orig and reg) then
                                    html:alternate($config, ., ("tei-choice6"), ., reg[1], orig[1], map {})
                                else
                                    $config?apply($config, ./node())
                    case element(cit) return
                        if (child::quote and child::bibl) then
                            (: Insert citation :)
                            html:cit($config, ., ("tei-cit"), ., ())
                        else
                            $config?apply($config, ./node())
                    case element(closer) return
                        html:block($config, ., ("tei-closer"), .)
                    case element(code) return
                        html:inline($config, ., ("tei-code"), .)
                    case element(corr) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            (: simple inline, if in parent choice. :)
                            html:inline($config, ., ("tei-corr1"), .)
                        else
                            html:inline($config, ., ("tei-corr2"), .)
                    case element(date) return
                        if (@when) then
                            html:alternate($config, ., ("tei-date3"), ., ., @when, map {})
                        else
                            if (text()) then
                                html:inline($config, ., ("tei-date4"), .)
                            else
                                $config?apply($config, ./node())
                    case element(dateline) return
                        html:block($config, ., ("tei-dateline"), .)
                    case element(del) return
                        html:inline($config, ., ("tei-del"), .)
                    case element(desc) return
                        html:inline($config, ., ("tei-desc"), .)
                    case element(div) return
                        if (@type='title_page') then
                            html:block($config, ., ("tei-div1"), .)
                        else
                            if (parent::body or parent::front or parent::back) then
                                html:section($config, ., ("tei-div2"), .)
                            else
                                html:block($config, ., ("tei-div3"), .)
                    case element(docAuthor) return
                        html:inline($config, ., ("tei-docAuthor"), .)
                    case element(docDate) return
                        html:inline($config, ., ("tei-docDate"), .)
                    case element(docEdition) return
                        html:inline($config, ., ("tei-docEdition"), .)
                    case element(docImprint) return
                        html:inline($config, ., ("tei-docImprint"), .)
                    case element(docTitle) return
                        html:block($config, ., css:get-rendition(., ("tei-docTitle")), .)
                    case element(editor) return
                        if (ancestor::teiHeader) then
                            html:omit($config, ., ("tei-editor1"), .)
                        else
                            html:inline($config, ., ("tei-editor2"), .)
                    case element(email) return
                        html:inline($config, ., ("tei-email"), .)
                    case element(epigraph) return
                        html:block($config, ., ("tei-epigraph"), .)
                    case element(ex) return
                        html:inline($config, ., ("tei-ex"), .)
                    case element(expan) return
                        html:inline($config, ., ("tei-expan"), .)
                    case element(figDesc) return
                        html:inline($config, ., ("tei-figDesc"), .)
                    case element(figure) return
                        if (head or @rendition='simple:display') then
                            html:block($config, ., ("tei-figure1"), .)
                        else
                            html:inline($config, ., ("tei-figure2"), .)
                    case element(floatingText) return
                        html:block($config, ., ("tei-floatingText"), .)
                    case element(foreign) return
                        html:inline($config, ., ("tei-foreign"), .)
                    case element(formula) return
                        if (@rendition='simple:display') then
                            html:block($config, ., ("tei-formula1"), .)
                        else
                            html:inline($config, ., ("tei-formula2"), .)
                    case element(front) return
                        html:block($config, ., ("tei-front"), .)
                    case element(fw) return
                        if (ancestor::p or ancestor::ab) then
                            html:inline($config, ., ("tei-fw1"), .)
                        else
                            html:block($config, ., ("tei-fw2"), .)
                    case element(g) return
                        if (not(text())) then
                            html:glyph($config, ., ("tei-g1"), .)
                        else
                            html:inline($config, ., ("tei-g2"), .)
                    case element(gap) return
                        if (desc) then
                            html:inline($config, ., ("tei-gap1"), .)
                        else
                            if (@extent) then
                                html:inline($config, ., ("tei-gap2"), @extent)
                            else
                                html:inline($config, ., ("tei-gap3"), .)
                    case element(graphic) return
                        html:graphic($config, ., ("tei-graphic"), ., @url, @width, @height, @scale, desc)
                    case element(group) return
                        html:block($config, ., ("tei-group"), .)
                    case element(head) return
                        if (parent::figure) then
                            html:block($config, ., ("tei-head1"), .)
                        else
                            if (parent::table) then
                                html:block($config, ., ("tei-head2"), .)
                            else
                                if (parent::lg) then
                                    html:block($config, ., ("tei-head3"), .)
                                else
                                    if (parent::list) then
                                        html:block($config, ., ("tei-head4"), .)
                                    else
                                        if (parent::div) then
                                            html:heading($config, ., ("tei-head5"), ., count(ancestor::div))
                                        else
                                            html:block($config, ., ("tei-head6"), .)
                    case element(hi) return
                        if (@rendition) then
                            html:inline($config, ., css:get-rendition(., ("tei-hi1")), .)
                        else
                            if (not(@rendition)) then
                                html:inline($config, ., ("tei-hi2"), .)
                            else
                                $config?apply($config, ./node())
                    case element(imprimatur) return
                        html:block($config, ., ("tei-imprimatur"), .)
                    case element(item) return
                        html:listItem($config, ., ("tei-item"), ., ())
                    case element(l) return
                        html:block($config, ., css:get-rendition(., ("tei-l")), .)
                    case element(label) return
                        html:inline($config, ., ("tei-label"), .)
                    case element(lb) return
                        html:break($config, ., css:get-rendition(., ("tei-lb")), ., 'line', @n)
                    case element(lg) return
                        html:block($config, ., ("tei-lg"), .)
                    case element(list) return
                        if (@rendition) then
                            html:list($config, ., css:get-rendition(., ("tei-list1")), item, ())
                        else
                            if (not(@rendition)) then
                                html:list($config, ., ("tei-list2"), item, ())
                            else
                                $config?apply($config, ./node())
                    case element(listBibl) return
                        if (bibl) then
                            html:list($config, ., ("tei-listBibl1"), bibl, ())
                        else
                            html:block($config, ., ("tei-listBibl2"), .)
                    case element(measure) return
                        html:inline($config, ., ("tei-measure"), .)
                    case element(milestone) return
                        html:inline($config, ., ("tei-milestone"), .)
                    case element(name) return
                        html:inline($config, ., ("tei-name"), .)
                    case element(note) return
                        if (@place) then
                            html:note($config, ., ("tei-note1"), ., @place, @n)
                        else
                            if (parent::div and not(@place)) then
                                html:block($config, ., ("tei-note2"), .)
                            else
                                if (not(@place)) then
                                    html:inline($config, ., ("tei-note3"), .)
                                else
                                    $config?apply($config, ./node())
                    case element(num) return
                        html:inline($config, ., ("tei-num"), .)
                    case element(opener) return
                        html:block($config, ., ("tei-opener"), .)
                    case element(orig) return
                        html:inline($config, ., ("tei-orig"), .)
                    case element(p) return
                        html:paragraph($config, ., css:get-rendition(., ("tei-p")), .)
                    case element(pb) return
                        html:break($config, ., css:get-rendition(., ("tei-pb")), ., 'page', (concat(if(@n) then concat(@n,' ') else '',if(@facs) then                   concat('@',@facs) else '')))
                    case element(pc) return
                        html:inline($config, ., ("tei-pc"), .)
                    case element(postscript) return
                        html:block($config, ., ("tei-postscript"), .)
                    case element(publisher) return
                        if (ancestor::teiHeader) then
                            (: Omit if located in teiHeader. :)
                            html:omit($config, ., ("tei-publisher"), .)
                        else
                            $config?apply($config, ./node())
                    case element(pubPlace) return
                        if (ancestor::teiHeader) then
                            (: Omit if located in teiHeader. :)
                            html:omit($config, ., ("tei-pubPlace"), .)
                        else
                            $config?apply($config, ./node())
                    case element(q) return
                        if (l) then
                            html:block($config, ., css:get-rendition(., ("tei-q1")), .)
                        else
                            if (ancestor::p or ancestor::cell) then
                                html:inline($config, ., css:get-rendition(., ("tei-q2")), .)
                            else
                                html:block($config, ., css:get-rendition(., ("tei-q3")), .)
                    case element(quote) return
                        if (ancestor::p) then
                            (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                            html:inline($config, ., css:get-rendition(., ("tei-quote1")), .)
                        else
                            (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                            html:block($config, ., css:get-rendition(., ("tei-quote2")), .)
                    case element(ref) return
                        if (not(@target)) then
                            html:inline($config, ., ("tei-ref1"), .)
                        else
                            if (not(text())) then
                                html:link($config, ., ("tei-ref2"), @target, @target, (), map {})
                            else
                                html:link($config, ., ("tei-ref3"), ., @target, (), map {})
                    case element(reg) return
                        html:inline($config, ., ("tei-reg"), .)
                    case element(relatedItem) return
                        html:inline($config, ., ("tei-relatedItem"), .)
                    case element(rhyme) return
                        html:inline($config, ., ("tei-rhyme"), .)
                    case element(role) return
                        html:block($config, ., ("tei-role"), .)
                    case element(roleDesc) return
                        html:block($config, ., ("tei-roleDesc"), .)
                    case element(row) return
                        if (@role='label') then
                            html:row($config, ., ("tei-row1"), .)
                        else
                            (: Insert table row. :)
                            html:row($config, ., ("tei-row2"), .)
                    case element(rs) return
                        html:inline($config, ., ("tei-rs"), .)
                    case element(s) return
                        html:inline($config, ., ("tei-s"), .)
                    case element(salute) return
                        if (parent::closer) then
                            html:inline($config, ., ("tei-salute1"), .)
                        else
                            html:block($config, ., ("tei-salute2"), .)
                    case element(seg) return
                        html:inline($config, ., css:get-rendition(., ("tei-seg")), .)
                    case element(sic) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            html:inline($config, ., ("tei-sic1"), .)
                        else
                            html:inline($config, ., ("tei-sic2"), .)
                    case element(signed) return
                        if (parent::closer) then
                            html:block($config, ., ("tei-signed1"), .)
                        else
                            html:inline($config, ., ("tei-signed2"), .)
                    case element(sp) return
                        html:block($config, ., ("tei-sp"), .)
                    case element(speaker) return
                        html:block($config, ., ("tei-speaker"), .)
                    case element(spGrp) return
                        html:block($config, ., ("tei-spGrp"), .)
                    case element(stage) return
                        html:block($config, ., ("tei-stage"), .)
                    case element(subst) return
                        html:inline($config, ., ("tei-subst"), .)
                    case element(supplied) return
                        if (parent::choice) then
                            html:inline($config, ., ("tei-supplied1"), .)
                        else
                            if (@reason='damage') then
                                html:inline($config, ., ("tei-supplied2"), .)
                            else
                                if (@reason='illegible' or not(@reason)) then
                                    html:inline($config, ., ("tei-supplied3"), .)
                                else
                                    if (@reason='omitted') then
                                        html:inline($config, ., ("tei-supplied4"), .)
                                    else
                                        html:inline($config, ., ("tei-supplied5"), .)
                    case element(table) return
                        html:table($config, ., ("tei-table"), .)
                    case element(fileDesc) return
                        html:title($config, ., ("tei-fileDesc"), titleStmt)
                    case element(profileDesc) return
                        html:omit($config, ., ("tei-profileDesc"), .)
                    case element(revisionDesc) return
                        html:omit($config, ., ("tei-revisionDesc"), .)
                    case element(encodingDesc) return
                        html:omit($config, ., ("tei-encodingDesc"), .)
                    case element(teiHeader) return
                        html:metadata($config, ., ("tei-teiHeader"), .)
                    case element(TEI) return
                        html:document($config, ., ("tei-TEI"), .)
                    case element(text) return
                        html:body($config, ., ("tei-text"), .)
                    case element(time) return
                        html:inline($config, ., ("tei-time"), .)
                    case element(title) return
                        if (parent::titleStmt/parent::fileDesc) then
                            (
                                if (preceding-sibling::title) then
                                    html:text($config, ., ("tei-title1"), ' — ')
                                else
                                    (),
                                html:inline($config, ., ("tei-title2"), .)
                            )

                        else
                            if (not(@level) and parent::bibl) then
                                html:inline($config, ., ("tei-title3"), .)
                            else
                                if (@level='m' or not(@level)) then
                                    (
                                        html:inline($config, ., ("tei-title4"), .),
                                        if (ancestor::biblFull) then
                                            html:text($config, ., ("tei-title5"), ', ')
                                        else
                                            ()
                                    )

                                else
                                    if (@level='s' or @level='j') then
                                        (
                                            html:inline($config, ., ("tei-title6"), .),
                                            if (following-sibling::* and     (  ancestor::biblFull)) then
                                                html:text($config, ., ("tei-title7"), ', ')
                                            else
                                                ()
                                        )

                                    else
                                        if (@level='u' or @level='a') then
                                            (
                                                html:inline($config, ., ("tei-title8"), .),
                                                if (following-sibling::* and     (    ancestor::biblFull)) then
                                                    html:text($config, ., ("tei-title9"), '. ')
                                                else
                                                    ()
                                            )

                                        else
                                            html:inline($config, ., ("tei-title10"), .)
                    case element(titlePage) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePage")), .)
                    case element(titlePart) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePart")), .)
                    case element(trailer) return
                        html:block($config, ., ("tei-trailer"), .)
                    case element(unclear) return
                        html:inline($config, ., ("tei-unclear"), .)
                    case element(w) return
                        html:inline($config, ., ("tei-w"), .)
                    case element(exist:match) return
                        html:match($config, ., .)
                    case element() return
                        if (namespace-uri(.) = 'http://www.tei-c.org/ns/1.0') then
                            $config?apply($config, ./node())
                        else
                            .
                    case text() | xs:anyAtomicType return
                        html:escapeChars(.)
                    default return 
                        $config?apply($config, ./node())

        )

};

declare function model:apply-children($config as map(*), $node as element(), $content as item()*) {
        
    if ($config?template) then
        $content
    else
        $content ! (
            typeswitch(.)
                case element() return
                    if (. is $node) then
                        $config?apply($config, ./node())
                    else
                        $config?apply($config, .)
                default return
                    html:escapeChars(.)
        )
};

declare function model:source($parameters as map(*), $elem as element()) {
        
    let $id := $elem/@exist:id
    return
        if ($id and $parameters?root) then
            util:node-by-id($parameters?root, $id)
        else
            $elem
};

