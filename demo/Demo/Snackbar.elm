module Demo.Snackbar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Html.Events as Html
import Json.Decode as Json
import Material
import Material.Button as Button
import Material.Checkbox as Checkbox
import Material.FormField as FormField
import Material.Options as Options exposing (cs, css, nop, styled, when)
import Material.Snackbar as Snackbar
import Material.Textfield as Textfield
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model m =
    { mdc : Material.Model m
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    }


type Msg m
    = Mdc (Material.Msg m)
    | Show String
    | Dismiss


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model

        Show index ->
            let
                contents =
                    let
                        toast =
                            Snackbar.toast (Just (lift Dismiss)) "Message Sent"
                    in
                    { toast
                        | dismissOnAction = True
                        , action = Just "Undo"
                    }

                ( mdc, cmds ) =
                    Snackbar.add (lift << Mdc) index contents model.mdc
            in
            ( { model | mdc = mdc }, cmds )

        Dismiss ->
            ( model, Cmd.none )


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Snackbar"
        , prelude =
            [ """
              Snackbars provide brief feedback about an operation through a
              message at the bottom of the screen.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Html.div
                [ Html.style "position" "relative"
                , Html.style "left" "0"
                , Html.style "transform" "none"
                , Html.class "mdc-snackbar mdc-snackbar--active"
                ]
                [ styled Html.div [ cs "mdc-snackbar__text" ] [ text "Message Sent" ]
                , styled Html.div
                    [ cs "mdc-snackbar__action-wrapper" ]
                    [ styled Html.button
                        [ Options.attribute (Html.type_ "button")
                        , cs "mdc-snackbar__action-button"
                        ]
                        [ text "Undo"
                        ]
                    ]
                ]
            ]
        , content =
            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Snackbars" ]
            , Button.view (lift << Mdc)
                "snackbar-snackbar-button"
                model.mdc
                [ cs "snackbar-demo-button"
                , Button.raised
                , Button.ripple
                , Button.onClick (lift (Show "snackbar-snackbar"))
                ]
                [ text "Show Snackbar"
                ]
            , Button.view (lift << Mdc)
                "snackbar-start-aligned-button"
                model.mdc
                [ cs "snackbar-demo-button"
                , Button.raised
                , Button.ripple
                , Button.onClick (lift (Show "snackbar-start-aligned"))
                ]
                [ text "Show Start Aligned"
                ]
            , Snackbar.view (lift << Mdc) "snackbar-snackbar" model.mdc [] []
            , Snackbar.view (lift << Mdc)
                "snackbar-start-aligned"
                model.mdc
                [ Snackbar.alignStart ]
                []
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .snackbar-demo-button {
      margin: 8px 16px;
    }
    """
