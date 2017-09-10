module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Icons as Icon
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
    | Video


type alias Resource =
    { title : String
    , summary : String
    , author : String
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
        , h2 [] [ text "An overview of useful Elm resources" ]
        , input [] []
        , levelFilterView model
        , categoryFilterView model
        ]


categoryFilterView : Model -> Html Msg
categoryFilterView model =
    nav []
        (List.map (filterItem << categoryToString)
            [ Example
            , Discussion
            , Article
            , Tutorial
            , Video
            ]
        )


levelFilterView : Model -> Html Msg
levelFilterView model =
    nav []
        (List.map (filterItem << levelToString)
            [ Beginner
            , Intermediate
            , Expert
            ]
        )


filterItem : String -> Html Msg
filterItem x =
    a [] [ text x ]


resourceListView : Model -> Html Msg
resourceListView model =
    section [] [ ul [] (List.map resourceListItem model.resources) ]


resourceListItem : Resource -> Html Msg
resourceListItem { title, summary, topic, category } =
    li [ class "resource-item" ]
        [ h3 [] [ text title ]
        , h6 [] [ text (categoryToString category) ]
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
    Resource "title" "SummarySummarySummarySummary" "Author" "url" Beginner Example [ "topic1" ]


levelToString : Level -> String
levelToString x =
    case x of
        Beginner ->
            "Beginner"

        Intermediate ->
            "Intermediate"

        Expert ->
            "Expert"


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

        Video ->
            "Video"
