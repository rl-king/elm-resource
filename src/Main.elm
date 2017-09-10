module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Set exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \x -> Sub.none
        }


type Level
    = Beginner
    | Intermediate
    | Expert


type Category
    = Example
    | Discussion
    | Article
    | Tutorial


type alias Resource =
    { title : String
    , summary : String
    , url : String
    , level : Level
    , category : Category
    , topic : List String
    }


type alias Model =
    { resources : List Resource
    , selectedCategory : Category
    }


init : ( Model, Cmd Msg )
init =
    { resources = data
    , selectedCategory = Article
    }
        ! []


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


view : Model -> Html Msg
view model =
    main_ []
        [ headerView model
        , resourceListView model
        ]


headerView : Model -> Html Msg
headerView model =
    header []
        [ h1 [] [ text "Elm Resource" ]
        , input [] []
        , levelSelectView model
        , categorySelectView model
        ]


categorySelectView : Model -> Html Msg
categorySelectView model =
    nav []
        (List.map (navItem << categoryToString)
            [ Example
            , Discussion
            , Article
            , Tutorial
            ]
        )


levelSelectView : Model -> Html Msg
levelSelectView model =
    nav []
        (List.map (navItem << levelToString)
            [ Beginner
            , Intermediate
            , Expert
            ]
        )


navItem : String -> Html Msg
navItem x =
    a [] [ text x ]


resourceListView : Model -> Html Msg
resourceListView model =
    ul [] (List.map resourceListItem model.resources)


resourceListItem : Resource -> Html Msg
resourceListItem { title, summary, topic } =
    li []
        [ h3 [] [ text title ]
        , p [] [ text summary ]
        , ul [] (List.map resourceTopic topic)
        ]


resourceTopic x =
    li [] [ text x ]


data : List Resource
data =
    [ sampleResource
    , sampleResource
    , sampleResource
    ]


sampleResource : Resource
sampleResource =
    Resource "title" "Summary" "url" Beginner Example [ "topic1" ]


levelToString : Level -> String
levelToString x =
    case x of
        Beginner ->
            "Beginner"

        Intermediate ->
            "Intermediate"

        Expert ->
            "Export"


categoryToString : Category -> String
categoryToString x =
    case x of
        Example ->
            "Example"

        Discussion ->
            "Discussion"

        Article ->
            "Article"

        Tutorial ->
            "Tutorial"
