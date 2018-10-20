module Demo.Switch exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Material
import Material.FormField as FormField
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Switch as Switch
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model m =
    { mdc : Material.Model m
    , states : Dict String Bool
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    , states = Dict.empty
    }


type Msg m
    = Mdc (Material.Msg m)
    | SwitchClicked Material.Index


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model

        SwitchClicked index ->
            let
                state =
                    Maybe.withDefault False (Dict.get index model.states)

                newState =
                    not state

                newStates =
                    Dict.insert index newState model.states
            in
            ( { model | states = newStates }, Cmd.none )


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Switch"
        , prelude =
            [ """
              Switches communicate an action a user can take. They are
              typically placed throughout your UI, in places like dialogs,
              forms, cards, and toolbars.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Page.hero []
                [ FormField.view []
                    [ Switch.view (lift << Mdc)
                        "switch-hero-switch"
                        model.mdc
                        [ Options.onClick (lift (SwitchClicked "switch-hero-switch"))
                        , when
                            (Maybe.withDefault False
                                (Dict.get "switch-hero-switch" model.states)
                            )
                            Switch.on
                        ]
                        []
                    ]
                ]
            ]
        , content =
            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Switch" ]
            , FormField.view []
                [ Switch.view (lift << Mdc)
                    "switch-default-switch"
                    model.mdc
                    [ Options.onClick (lift (SwitchClicked "switch-default-switch"))
                    , when
                        (Maybe.withDefault False
                            (Dict.get "switch-default-switch" model.states)
                        )
                        Switch.on
                    ]
                    []
                , styled Html.label
                    [ Options.for "switch-default-switch" ]
                    [ text "off/on" ]
                ]
            ]
        }
