module Demo.Ripple exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Material
import Material.Elevation as Elevation
import Material.Options as Options exposing (cs, css, styled)
import Material.Ripple as Ripple
import Material.Typography as Typography


-- MODEL


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
    page.demoPage
        { title = "Ripple"
        , prelude =
            [ """
              Ripples are visual representations used to communicate the status
              of a component or interactive element.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ let
                ripple =
                    Ripple.bounded (lift << Mdc) "ripple-hero-ripple" model.mdc []
              in
              styled Html.div
                [ cs "ripple-demo-box mdc-ripple-surface"
                , ripple.interactionHandler
                , ripple.properties
                ]
                [ text "Click here!"
                , ripple.style
                ]
            ]
        , content =
            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Bounded Ripple" ]
            , let
                ripple =
                    Ripple.bounded (lift << Mdc) "ripple-bounded-ripple" model.mdc []
              in
              styled Html.div
                [ cs "ripple-demo-box mdc-ripple-surface"
                , ripple.interactionHandler
                , ripple.properties
                ]
                [ text "Interact with me!"
                , ripple.style
                ]
            , styled Html.h3 [ Typography.subtitle1 ] [ text "Unbounded Ripple" ]
            , let
                ripple =
                    Ripple.unbounded (lift << Mdc) "ripple-unbounded-ripple" model.mdc []
              in
              styled Html.div
                [ cs "ripple-demo-icon material-icons"
                , cs "mdc-ripple-surface"
                , ripple.interactionHandler
                , ripple.properties
                ]
                [ text "favorite"
                , ripple.style
                ]
            , styled Html.h3 [ Typography.subtitle1 ] [ text "Theme Colors: Primary" ]
            , let
                ripple =
                    Ripple.bounded (lift << Mdc) "ripple-primary-ripple" model.mdc []
              in
              styled Html.div
                [ cs "ripple-demo-box ripple-demo-box--primary"
                , cs "mdc-ripple-surface"
                , ripple.interactionHandler
                , ripple.properties
                ]
                [ text "Primary"
                , ripple.style
                ]
            , styled Html.h3 [ Typography.subtitle1 ] [ text "Theme Colors: Secondary" ]
            , let
                ripple =
                    Ripple.bounded (lift << Mdc) "ripple-secondary-ripple" model.mdc []
              in
              styled Html.div
                [ cs "ripple-demo-box ripple-demo-box--secondary"
                , cs "mdc-ripple-surface"
                , ripple.interactionHandler
                , ripple.properties
                ]
                [ text "Secondary"
                , ripple.style
                ]
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .ripple-demo-box,
    .ripple-demo-icon {
      will-change: transform,opacity;
      cursor: pointer;
      outline: none;
    }

    .ripple-demo-box {
      -webkit-box-shadow: 0 3px 1px -2px rgba(0,0,0,.2),0 2px 2px 0 rgba(0,0,0,.14),0 1px 5px 0 rgba(0,0,0,.12);
      box-shadow: 0 3px 1px -2px rgba(0,0,0,.2),0 2px 2px 0 rgba(0,0,0,.14),0 1px 5px 0 rgba(0,0,0,.12);
      display: -ms-flexbox;
      display: flex;
      -ms-flex-align: center;
      align-items: center;
      -ms-flex-pack: center;
      justify-content: center;
      width: 200px;
      height: 100px;
      padding: 1rem;
      cursor: pointer;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
      -webkit-user-select: none;
      background-color: #fff;
      overflow: hidden;
    }

    .ripple-demo-icon {
      width: 24px;
      height: 24px;
      font-size: 24px;
      padding: 12px;
      overflow: visible;
    }

    .ripple-demo-box--primary {
      color: #6200ee;
      color: var(--mdc-theme-primary,#6200ee);
    }

    .ripple-demo-box--primary:before,
    .ripple-demo-box--primary:after {
      background-color: #6200ee;
      background-color: var(--mdc-theme-primary,#6200ee);
    }

    .ripple-demo-box--secondary {
      color: #018786;
      color: var(--mdc-theme-secondary,#018786);
    }

    .ripple-demo-box--secondary:before,
    .ripple-demo-box--secondary:after {
      background-color: #018786;
      background-color: var(--mdc-theme-secondary,#018786);
    }
    """
