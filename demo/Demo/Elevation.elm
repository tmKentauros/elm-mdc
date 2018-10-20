module Demo.Elevation exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Material
import Material.Elevation as Elevation
import Material.Options as Options exposing (cs, css, styled, when)


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


elevationDemoSurface : Options.Property c m -> String -> Html m
elevationDemoSurface elevation label =
    styled Html.div
        [ cs "elevation-demo-surface"
        , elevation
        ]
        [ text label ]


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Elevation"
        , prelude =
            [ """
              Elevation is the relative depth, or distance, between two
              surfaces along the z-axis.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Html.div
                [ Html.class "elevation-hero" ]
                [ elevationDemoSurface Elevation.z0 "Flat 0dp"
                , elevationDemoSurface Elevation.z8 "Raised 8dp"
                , elevationDemoSurface Elevation.z16 "Raised 16dp"
                ]
            ]
        , content =
            [ Html.div
                [ Html.class "elevation-demo-container" ]
                [ elevationDemoSurface Elevation.z0 "0dp"
                , elevationDemoSurface Elevation.z1 "1dp"
                , elevationDemoSurface Elevation.z2 "2dp"
                , elevationDemoSurface Elevation.z3 "3dp"
                , elevationDemoSurface Elevation.z4 "4dp"
                , elevationDemoSurface Elevation.z5 "5dp"
                , elevationDemoSurface Elevation.z6 "6dp"
                , elevationDemoSurface Elevation.z7 "7dp"
                , elevationDemoSurface Elevation.z8 "8dp"
                , elevationDemoSurface Elevation.z9 "9dp"
                , elevationDemoSurface Elevation.z10 "10dp"
                , elevationDemoSurface Elevation.z11 "11dp"
                , elevationDemoSurface Elevation.z12 "12dp"
                , elevationDemoSurface Elevation.z13 "13dp"
                , elevationDemoSurface Elevation.z14 "14dp"
                , elevationDemoSurface Elevation.z15 "15dp"
                , elevationDemoSurface Elevation.z16 "16dp"
                , elevationDemoSurface Elevation.z17 "17dp"
                , elevationDemoSurface Elevation.z18 "18dp"
                , elevationDemoSurface Elevation.z19 "19dp"
                , elevationDemoSurface Elevation.z20 "20dp"
                , elevationDemoSurface Elevation.z21 "21dp"
                , elevationDemoSurface Elevation.z22 "22dp"
                , elevationDemoSurface Elevation.z23 "23dp"
                , elevationDemoSurface Elevation.z24 "24dp"
                ]
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .elevation-demo-container {
      display: -ms-flexbox;
      display: flex;
      margin: auto;
      -ms-flex: 1 1 auto;
      flex: 1 1 auto;
      -ms-flex-wrap: wrap;
      flex-wrap: wrap;
      -ms-flex-pack: justify;
      justify-content: space-between;
      width: 100%;
    }

    .elevation-hero .elevation-demo-surface {
      width: 120px;
      height: 48px;
      margin: 24px;
      background-color: #212121;
      color: #f0f0f0;
    }

    .elevation-demo-surface {
      display: -ms-inline-flexbox;
      display: inline-flex;
      -ms-flex-pack: distribute;
      justify-content: space-around;
      min-height: 100px;
      min-width: 200px;
      margin: 15px;
      -ms-flex-align: center;
      align-items: center;
    }
    """
