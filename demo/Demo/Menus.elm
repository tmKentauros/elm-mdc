module Demo.Menus exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Html.Events as Html
import Json.Decode as Json
import Material
import Material.Button as Button
import Material.List as Lists
import Material.Menu as Menu
import Material.Options as Options exposing (cs, css, nop, styled, when)
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


subscriptions : (Msg m -> m) -> Model m -> Sub m
subscriptions lift model =
    Material.subscriptions (lift << Mdc) model


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Menu"
        , prelude =
            [ """
              Menus display a list of choices on a transient sheet of material.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Menu.view (lift << Mdc)
                "menus-hero-menu"
                model.mdc
                [ cs "hero-menu"
                , cs "mdc-menu--open"
                ]
                (Menu.ul []
                    [ Menu.li [] [ text "A Menu Item" ]
                    , Menu.li [] [ text "Another Menu Item" ]
                    ]
                )
            ]
        , content =
            [ styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Anchored Menu" ]
            , Button.view (lift << Mdc)
                "menus-anchored-menu-button"
                model.mdc
                [ Button.ripple
                , Menu.attach (lift << Mdc) "menus-anchored-menu"
                ]
                [ text "Open Menu" ]
            , Html.div
                [ Html.class "mdc-menu-surface--anchor" ]
                [ Menu.view (lift << Mdc)
                    "menus-anchored-menu"
                    model.mdc
                    []
                    (Menu.ul []
                        [ Menu.li [] [ text "Passionfruit" ]
                        , Menu.li [] [ text "Orange" ]
                        , Menu.li [] [ text "Guava" ]
                        , Menu.li [] [ text "Pitaya" ]
                        , Menu.divider [] []
                        , Menu.li [] [ text "Pineapple" ]
                        , Menu.li [] [ text "Magno" ]
                        , Menu.li [] [ text "Papaya" ]
                        , Menu.li [] [ text "Lychee" ]
                        ]
                    )
                ]
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .hero-menu {
      position: relative;
      z-index: 0;
    }

    .mdc-menu-surface--anchor {
      position: relative;
      overflow: visible;
    }
    """
