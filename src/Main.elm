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
    | Advanced


type Category
    = Example
    | Discussion
    | Article
    | Tutorial
    | Video
    | Exercise


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
    , selectedCategory : Maybe Category
    , selectedLevel : Maybe Level
    }


init : ( Model, Cmd Msg )
init =
    { resources = data
    , selectedCategory = Nothing
    , selectedLevel = Nothing
    }
        ! []


type Msg
    = SelectCategoryFilter Category
    | SelectLevelFilter Level


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectCategoryFilter category ->
            let
                selected =
                    if model.selectedCategory == Just category then
                        Nothing
                    else
                        Just category
            in
            { model | selectedCategory = selected } ! []

        SelectLevelFilter level ->
            let
                selected =
                    if model.selectedLevel == Just level then
                        Nothing
                    else
                        Just level
            in
            { model | selectedLevel = selected } ! []


view : Model -> Html Msg
view model =
    main_ []
        [ headerView model
        , resourceListView model
        ]


headerView : Model -> Html Msg
headerView model =
    header []
        [ div [ class "titles" ]
            [ h1 [] [ text "Elm Resource" ]
            , h3 [] [ text "A handmade list of useful Elm resources" ]
            ]
        , levelFilterView model
        , categoryFilterView model
        ]


categoryFilterView : Model -> Html Msg
categoryFilterView model =
    nav [] <|
        span [] [ text "Categories" ]
            :: List.map (filterItem SelectCategoryFilter categoryToString)
                [ Example
                , Discussion
                , Article
                , Tutorial
                , Video
                , Exercise
                ]


levelFilterView : Model -> Html Msg
levelFilterView model =
    nav [] <|
        span [] [ text "Level" ]
            :: List.map (filterItem SelectLevelFilter levelToString)
                [ Beginner
                , Intermediate
                , Advanced
                ]


filterItem : (a -> Msg) -> (a -> String) -> a -> Html Msg
filterItem msg fn x =
    a [ onClick (msg x), class "filter-item" ] [ text (fn x) ]


resourceListView : Model -> Html Msg
resourceListView model =
    section [] [ ul [ class "resource-list" ] (List.map resourceListItem model.resources) ]


resourceListItem : Resource -> Html Msg
resourceListItem { title, summary, topic, category, author } =
    li [ class "resource-item" ]
        [ h3 [] [ text title ]
        , h6 [ class "category" ] [ text (categoryToString category) ]
        , h5 [] [ text author ]
        , p [] [ text summary ]
        , ul [ class "topics" ] (List.map resourceTopic topic)
        ]


resourceTopic x =
    li [ class "topic" ] [ text x ]


data : List Resource
data =
    [ Resource "Real World SPA" "Elm codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the RealWorld spec and API." "Richard Feldman" "https://github.com/rtfeldman/elm-spa-example" Advanced Example [ "Single Page App", "Authentication" ]
    , Resource "Real World SPA" "Elm codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the RealWorld spec and API." "Richard Feldman" "https://github.com/rtfeldman/elm-spa-example" Advanced Example [ "Single Page App", "Authentication" ]
    , Resource "Real World SPA" "Elm codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the RealWorld spec and API." "Richard Feldman" "https://github.com/rtfeldman/elm-spa-example" Beginner Example [ "Single Page App", "Authentication" ]
    , Resource "Real World SPA" "Elm codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the RealWorld spec and API." "Richard Feldman" "https://github.com/rtfeldman/elm-spa-example" Advanced Example [ "Single Page App", "Authentication" ]
    , Resource "Real World SPA" "Elm codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the RealWorld spec and API." "Richard Feldman" "https://github.com/rtfeldman/elm-spa-example" Advanced Example [ "Single Page App", "Authentication" ]
    , Resource "Real World SPA" "Elm codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the RealWorld spec and API." "Richard Feldman" "https://github.com/rtfeldman/elm-spa-example" Advanced Example [ "Single Page App", "Authentication" ]
    ]


levelToString : Level -> String
levelToString x =
    case x of
        Beginner ->
            "Beginner"

        Intermediate ->
            "Intermediate"

        Advanced ->
            "Advanced"


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

        Exercise ->
            "Exercise"
