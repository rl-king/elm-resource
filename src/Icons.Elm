module Icons exposing (..)

import Svg exposing (..)
import Svg.Attributes as A exposing (..)


logo : Svg msg
logo =
    svg [ width "24px", height "17px", A.viewBox "0 0 24 17" ]
        [ desc []
            [ text "Created with Sketch." ]
        , defs []
            []
        , g [ id "Page-1", stroke "none", strokeWidth "1", fill "none" ]
            [ g [ id "Group-2" ]
                [ rect [ fill "#F5A623", x "0", y "5", width "24", height "3" ] []
                , rect [ fill "#5A6378", x "0", y "0", width "24", height "3" ] []
                , rect [ fill "#7FD13B", x "0", y "10", width "24", height "3" ] []
                , rect [ fill "#60B5CC", x "0", y "15", width "18", height "3" ] []
                ]
            ]
        ]
