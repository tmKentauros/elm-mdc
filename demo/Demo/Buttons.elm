module Demo.Buttons exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page exposing (Page)
import Html exposing (Html, text)
import Material
import Material.Button as Button
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Typography as Typography


type alias Model m =
    { mdc : Material.Model m
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    }


type Msg m
    = Mdc (Material.Msg m)


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    let
        textButtons idx =
            example idx
                lift
                model
                { title = "Text Button"
                , additionalOptions =
                    [ Button.ripple
                    , css "margin" "8px 16px"
                    ]
                }

        raisedButtons idx =
            example idx
                lift
                model
                { title = "Raised Button"
                , additionalOptions =
                    [ Button.raised
                    , Button.ripple
                    , css "margin" "8px 16px"
                    ]
                }

        unelevatedButtons idx =
            example idx
                lift
                model
                { title = "Unelevated Button"
                , additionalOptions =
                    [ Button.unelevated
                    , Button.ripple
                    , css "margin" "8px 16px"
                    ]
                }

        outlinedButtons idx =
            example idx
                lift
                model
                { title = "Outlined Button"
                , additionalOptions =
                    [ Button.outlined
                    , Button.ripple
                    , css "margin" "8px 16px"
                    ]
                }
    in
    page.demoPage
        { title = "Button"
        , prelude =
            [ """
              Buttons communicate an action a user can take. They are typically
              placed throughout your UI, in places like dialogs, forms, cards, and
              toolbars.
              """
            ]
        , resources =
            { materialGuidelines = "https://material.io/go/design-buttons"
            , documentation = "https://material.io/components/web/catalog/buttons"
            , sourceCode = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-button"
            }
        , hero =
            [ Button.view (lift << Mdc)
                "buttons-hero-button-flat"
                model.mdc
                [ Button.ripple
                , css "margin" "16px 32px"
                ]
                [ text "Flat"
                ]
            , Button.view (lift << Mdc)
                "buttons-hero-button-raised"
                model.mdc
                [ Button.ripple
                , Button.raised
                , css "margin" "16px 32px"
                ]
                [ text "Raised"
                ]
            , Button.view (lift << Mdc)
                "buttons-hero-button-unelevated"
                model.mdc
                [ Button.ripple
                , Button.unelevated
                , css "margin" "16px 32px"
                ]
                [ text "Unelevated"
                ]
            , Button.view (lift << Mdc)
                "buttons-hero-button-outlined"
                model.mdc
                [ Button.ripple
                , Button.outlined
                , css "margin" "16px 32px"
                ]
                [ text "Outlined"
                ]
            ]
        , content =
            [ textButtons "buttons-text-buttons"
            , raisedButtons "buttons-raised-buttons"
            , unelevatedButtons "buttons-unelevated-buttons"
            , outlinedButtons "buttons-outlined-buttons"
            ]
        }


example :
    String
    -> (Msg m -> m)
    -> { a | mdc : Material.Model m }
    ->
        { title : String
        , additionalOptions : List (Button.Property m)
        }
    -> Html m
example idx lift model { title, additionalOptions } =
    Html.div []
        [ styled Html.h3
            [ Typography.subtitle1
            ]
            [ text title
            ]
        , Button.view (lift << Mdc)
            (idx ++ "-default-button")
            model.mdc
            additionalOptions
            [ text "Baseline" ]
        , Button.view (lift << Mdc)
            (idx ++ "-dense-button")
            model.mdc
            (Button.dense :: additionalOptions)
            [ text "Dense" ]
        , Button.view (lift << Mdc)
            (idx ++ "-icon-button")
            model.mdc
            (Button.icon "favorite" :: additionalOptions)
            [ text "Icon" ]
        ]
