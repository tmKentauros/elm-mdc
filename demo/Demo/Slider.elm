module Demo.Slider exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes as Html
import Html.Events as Html
import Json.Decode as Json exposing (Decoder)
import Material
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Slider as Slider
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model m =
    { mdc : Material.Model m
    , states : Dict Material.Index Float
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    , states =
        Dict.fromList
            [ ( "slider-hero-slider", 25 )
            , ( "slider-continuous-slider", 25 )
            , ( "slider-discrete-slider", 25 )
            , ( "slider-tick-marks-slider", 25 )
            ]
    }


type Msg m
    = Mdc (Material.Msg m)
    | SliderChanged String Float


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model

        SliderChanged index value ->
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
        { title = "Slider"
        , prelude =
            [ """
              Sliders let users select from a range of values by moving the
              slider thumb.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Slider.view (lift << Mdc)
                "slider-hero-slider"
                model.mdc
                [ Slider.value
                    (Maybe.withDefault 0
                        (Dict.get "slider-hero-slider" model.states)
                    )
                , Slider.onChange (lift << SliderChanged "slider-hero-slider")
                , Slider.min 0
                , Slider.max 50
                ]
                []
            ]
        , content =
            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Continuous" ]
            , Slider.view
                (lift << Mdc)
                "slider-continuous-slider"
                model.mdc
                [ Slider.value
                    (Maybe.withDefault 0
                        (Dict.get "slider-continuous-slider" model.states)
                    )
                , Slider.onChange (lift << SliderChanged "slider-continuous-slider")
                , Slider.min 0
                , Slider.max 50
                ]
                []
            , styled Html.h3 [ Typography.subtitle1 ] [ text "Discrete" ]
            , Slider.view
                (lift << Mdc)
                "slider-discrete-slider"
                model.mdc
                [ Slider.value
                    (Maybe.withDefault 0
                        (Dict.get "slider-discrete-slider" model.states)
                    )
                , Slider.onChange (lift << SliderChanged "slider-discrete-slider")
                , Slider.discrete
                , Slider.min 0
                , Slider.max 50
                ]
                []
            , styled Html.h3 [ Typography.subtitle1 ] [ text "Discrete with Tick Marks" ]
            , Slider.view (lift << Mdc)
                "slider-tick-marks-slider"
                model.mdc
                [ Slider.value
                    (Maybe.withDefault 0
                        (Dict.get "slider-tick-marks-slider" model.states)
                    )
                , Slider.onChange (lift << SliderChanged "slider-tick-marks-slider")
                , Slider.trackMarkers
                , Slider.min 0
                , Slider.max 50
                ]
                []
            ]
        }
