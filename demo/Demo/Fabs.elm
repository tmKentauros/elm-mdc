module Demo.Fabs exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Html.Events as Html
import Material
import Material.Fab as Fab
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
    page.demoPage
        { title = "Floating Action Button"
        , prelude =
            [ """
              Floating action buttons represents the primary action in an
              application. Only one floating action button is recommended per
              screen to represent the most common action.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Fab.view (lift << Mdc)
                "fabs-hero-fab"
                model.mdc
                [ Fab.ripple ]
                "favorite_border"
            ]
        , content =
            [ styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Standard Floating Action Button" ]
            , Fab.view (lift << Mdc)
                "fabs-standard-fab"
                model.mdc
                [ Fab.ripple ]
                "favorite_border"
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Mini Floating Action Button" ]
            , Fab.view (lift << Mdc)
                "fabs-mini-fab"
                model.mdc
                [ Fab.ripple
                , Fab.mini
                ]
                "favorite_border"
            ]
        }
