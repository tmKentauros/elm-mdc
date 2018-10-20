module Demo.Selects exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Array
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes as Html
import Html.Events as Html
import Material
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Select as Select
import Material.Typography as Typography


type alias Model m =
    { mdc : Material.Model m
    , states : Dict String String
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    , states = Dict.empty
    }


type Msg m
    = Mdc (Material.Msg m)
    | SelectChanged String String


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model

        SelectChanged index value ->
            let
                newStates =
                    Dict.insert index value model.states
            in
            ( { model | states = newStates }, Cmd.none )


subscriptions : (Msg m -> m) -> Model m -> Sub m
subscriptions lift model =
    Material.subscriptions (lift << Mdc) model


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Select"
        , prelude =
            [ """
              Selects allow users to select from a single-option menu. It
              functions as a wrapper around the browser's native <select>
              element.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Select.view (lift << Mdc)
                "selects-hero-select"
                model.mdc
                [ cs "demo-select"
                , Select.label "Fruit"
                , Options.onChange (lift << SelectChanged "selects-hero-select")
                ]
                (List.indexedMap
                    (\index label ->
                        Select.option
                            [ Select.value label
                            , when (Dict.get "selects-hero-select" model.states == Just label)
                                Select.selected
                            ]
                            [ text label ]
                    )
                    fruits
                )
            ]
        , content =
            [ Html.div []
                [ styled Html.h3 [ Typography.subtitle1 ] [ text "Select" ]
                , Select.view (lift << Mdc)
                    "selects-default-select"
                    model.mdc
                    [ cs "demo-select"
                    , Select.label "Fruit"
                    , Options.onChange (lift << SelectChanged "selects-default-select")
                    ]
                    (List.indexedMap
                        (\index label ->
                            Select.option
                                [ Select.value label
                                , when (Dict.get "selects-default-select" model.states == Just label)
                                    Select.selected
                                ]
                                [ text label ]
                        )
                        fruits
                    )
                ]
            , Html.div []
                [ styled Html.h3 [ Typography.subtitle1 ] [ text "Box Select" ]
                , Select.view (lift << Mdc)
                    "selects-default-select"
                    model.mdc
                    [ cs "demo-select"
                    , Select.box
                    , Select.label "Fruit"
                    , Options.onChange (lift << SelectChanged "selects-default-select")
                    ]
                    (List.indexedMap
                        (\index label ->
                            Select.option
                                [ Select.value label
                                , when (Dict.get "selects-default-select" model.states == Just label)
                                    Select.selected
                                ]
                                [ text label ]
                        )
                        fruits
                    )
                ]
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


fruits : List String
fruits =
    [ "Apple"
    , "Orange"
    , "Banana"
    ]


style : String
style =
    """
    .demo-select {
      min-width: 300px;
    }
    """
