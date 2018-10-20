module Demo.RadioButtons exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes as Html
import Material
import Material.FormField as FormField
import Material.Options as Options exposing (cs, css, styled, when)
import Material.RadioButton as RadioButton
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model m =
    { mdc : Material.Model m
    , states : Dict String Bool
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    , states = Dict.fromList []
    }


type Msg m
    = Mdc (Material.Msg m)
    | RadioClicked String Bool


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model

        RadioClicked index value ->
            let
                newStates =
                    Dict.insert index value model.states
            in
            ( { model | states = newStates }, Cmd.none )


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Radio Button"
        , prelude =
            [ """
              Buttons communicate an action a user can take. They are typically
              placed throughout your UI, in places like dialogs, forms, cards,
              and toolbars.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Html.div []
                [ RadioButton.view (lift << Mdc)
                    "radio-buttons-hero-radio-1"
                    model.mdc
                    [ cs "demo-radio"
                    , Options.onClick (lift (RadioClicked "hero" False))
                    , when (Maybe.withDefault False (Dict.get "hero" model.states) == False)
                        RadioButton.selected
                    ]
                    []
                , RadioButton.view (lift << Mdc)
                    "radio-buttons-hero-radio-2"
                    model.mdc
                    [ cs "demo-radio"
                    , Options.onClick (lift (RadioClicked "hero" True))
                    , when (Maybe.withDefault False (Dict.get "hero" model.states) == True)
                        RadioButton.selected
                    ]
                    []
                ]
            ]
        , content =
            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Radio Buttons" ]
            , FormField.view
                [ cs "demo-radio-form-field" ]
                [ RadioButton.view (lift << Mdc)
                    "radio-buttons-default-radio-1"
                    model.mdc
                    [ Options.onClick (lift (RadioClicked "content" False))
                    , when (Maybe.withDefault False (Dict.get "content" model.states) == False)
                        RadioButton.selected
                    ]
                    []
                , Html.label
                    [ Html.for "radio-buttons-default-radio-1" ]
                    [ text "Radio 1" ]
                ]
            , FormField.view
                [ cs "demo-radio-form-field" ]
                [ RadioButton.view (lift << Mdc)
                    "radio-buttons-default-radio-2"
                    model.mdc
                    [ Options.onClick (lift (RadioClicked "content" True))
                    , when (Maybe.withDefault False (Dict.get "content" model.states) == True)
                        RadioButton.selected
                    ]
                    []
                , Html.label
                    [ Html.for "radio-buttons-default-radio-2" ]
                    [ text "Radio 2" ]
                ]
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .demo-radio,
    .demo-radio-form-field {
      margin: 0 10px;
    }
    """
