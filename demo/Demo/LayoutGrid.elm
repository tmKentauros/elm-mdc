module Demo.LayoutGrid
    exposing
        ( Model
        , Msg(..)
        , defaultModel
        , update
        , view
        )

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Html.Events as Html
import Json.Decode as Json
import Material
import Material.LayoutGrid as LayoutGrid
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Typography as Typography
import Task


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
        { title = "Layout Grid"
        , prelude =
            [ """
              Material design’s responsive UI is based on a 12-column grid layout.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ LayoutGrid.view
                [ cs "demo-grid" ]
                (List.repeat 3 <|
                    LayoutGrid.cell [ cs "demo-cell" ] []
                )
            ]
        , content =
            [ styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Columns" ]
            , LayoutGrid.view
                [ cs "demo-grid" ]
                [ LayoutGrid.cell [ cs "demo-cell", LayoutGrid.span6 ] []
                , LayoutGrid.cell [ cs "demo-cell", LayoutGrid.span3 ] []
                , LayoutGrid.cell [ cs "demo-cell", LayoutGrid.span2 ] []
                , LayoutGrid.cell [ cs "demo-cell", LayoutGrid.span1 ] []
                , LayoutGrid.cell [ cs "demo-cell", LayoutGrid.span3 ] []
                , LayoutGrid.cell [ cs "demo-cell", LayoutGrid.span1 ] []
                , LayoutGrid.cell [ cs "demo-cell", LayoutGrid.span8 ] []
                ]
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Grid Left Alignment" ]
            , styled Html.p
                [ Typography.body2 ]
                [ text "This requires a max-width on the top-level grid element." ]
            , LayoutGrid.view
                [ cs "demo-grid demo-grid--alignment"
                , LayoutGrid.alignLeft
                ]
                (List.repeat 3 <|
                    LayoutGrid.cell [ cs "demo-cell" ] []
                )
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Right Alignment" ]
            , styled Html.p
                [ Typography.body2 ]
                [ text "This requires a max-width on the top-level grid element." ]
            , LayoutGrid.view
                [ cs "demo-grid demo-grid--alignment"
                , LayoutGrid.alignRight
                ]
                (List.repeat 3 <|
                    LayoutGrid.cell [ cs "demo-cell" ] []
                )
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Cell Alignment" ]
            , styled Html.p
                [ Typography.body2 ]
                [ text "Cell alignment requires a cell height smaller than the inner height of the grid." ]
            , LayoutGrid.view
                [ cs "demo-grid demo-grid--cell-alignment"
                , LayoutGrid.alignLeft
                ]
                [ LayoutGrid.cell
                    [ cs "demo-cell demo-cell--alignment", LayoutGrid.alignTop ]
                    []
                , LayoutGrid.cell
                    [ cs "demo-cell demo-cell--alignment", LayoutGrid.alignMiddle ]
                    []
                , LayoutGrid.cell
                    [ cs "demo-cell demo-cell--alignment", LayoutGrid.alignBottom ]
                    []
                ]
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .demo-grid {
      background: rgba(0,0,0,.2);
      min-width: 360px;
    }

    .demo-cell {
      background: rgba(0,0,0,.2);
      height: 100px;
    }

    .demo-grid--alignment {
      max-width: 800px;
    }

    .demo-grid--cell-alignment .mdc-layout-grid__inner {
      min-height: 200px;
    }

    .demo-cell--alignment {
      max-height: 50px;
    }
    """
