port module Stylesheets exposing (..)

import Css exposing (..)
import Css.Elements as E
import Css.File
import Css.Media as Media
import ModularScale


port files : Css.File.CssFileStructure -> Cmd msg


cssFiles : Css.File.CssFileStructure
cssFiles =
    Css.File.toFileStructure [ ( "main.css", Css.compile [ css ] ) ]


main : Css.File.CssCompilerProgram
main =
    Css.File.compiler files cssFiles


css : Stylesheet
css =
    Css.stylesheet <|
        List.concat
            [ base
            , typography
            , header
            , containers
            ]



-- BASE


base : List Css.Snippet
base =
    [ E.html
        [ fontSize (pct <| 100 * 12 / 16)
        ]
    , E.body
        [ margin zero
        , fontFamilies sans
        ]
    ]



-- TYPOGRAPHY


typography : List Css.Snippet
typography =
    [ E.h1
        [ padding zero
        , margin zero
        , fontSize (ms 3)
        , fontWeight (int 500)
        ]
    , E.h2
        [ padding2 (ms -1) zero
        , margin zero
        , fontSize (ms 2)
        , lineHeight (ms 2)
        , fontWeight (int 500)
        ]
    , E.h3
        [ padding zero
        , margin zero
        , fontSize (ms 2)
        , lineHeight (ms 3)
        , fontWeight (int 400)
        ]
    , E.h6
        [ padding zero
        , margin zero
        , fontSize (ms 0)
        , lineHeight (ms 3)
        , fontWeight (int 400)
        ]
    , E.p
        [ color (mono B3)
        , margin zero
        , fontSize (ms 1)
        , lineHeight (ms 3)
        ]
    , E.a
        [ color (mono B1)
        , textDecoration none
        ]
    , E.ul
        [ padding zero
        , margin zero
        , listStyle none
        ]
    ]


header =
    [ E.header
        [ padding (ms 1)
        ]
    , E.nav
        [ descendants
            [ E.a
                [ paddingRight (ms 1)
                , cursor pointer
                ]
            ]
        ]
    ]



-- CONTAINERS


containers =
    [ E.section
        [ padding (ms 1)
        ]
    , class "resource-item"
        [ backgroundColor (mono W2)
        , padding (ms 1)
        , margin (ms 1)
        ]
    ]



-- ELEMENTS
-- MODULARSCALE


config : ModularScale.Config
config =
    { base = [ 1, 1.2 ]
    , interval = ModularScale.PerfectFifth
    }


ms : Int -> Rem
ms =
    Css.rem << ModularScale.get config


smallDisplay : List Style -> Style
smallDisplay =
    Media.withMediaQuery [ "screen and (min-width: 768px)" ]


largeDisplay : List Style -> Style
largeDisplay =
    Media.withMediaQuery [ "screen and (min-width: 1280px)" ]



-- VARIABLES


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


type Mono
    = B1
    | B2
    | B3
    | B4
    | W1
    | W2
    | W3
    | W4
    | G1
    | G2
    | G3
    | G4


monoValues : List ( Mono, Int )
monoValues =
    [ B1 => 6
    , B2 => 18
    , B3 => 26
    , B4 => 30
    , W1 => 255
    , W2 => 249
    , W3 => 243
    , W4 => 237
    , G1 => 164
    , G2 => 188
    , G3 => 212
    , G4 => 224
    ]


mono : Mono -> Color
mono v =
    case List.filter ((==) v << Tuple.first) monoValues of
        [ ( x, y ) ] ->
            rgb y y y

        _ ->
            rgba 0 0 0 0


sans : List String
sans =
    [ "-apple-system"
    , "BlinkMacSystemFont"
    , "Segoe UI"
    , "Roboto"
    , "Oxygen"
    , "Ubuntu"
    , "Cantarell"
    , "Fira Sans"
    , "Droid Sans"
    , "Helvetica Neue"
    , "sans-serif"
    ]
