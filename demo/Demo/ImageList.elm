module Demo.ImageList exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Material
import Material.ImageList as ImageList
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
        { title = "Image List"
        , prelude =
            [ """
              Image lists display a collection of images in an organized grid.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ ImageList.view
                [ cs "hero-image-list"
                ]
                (List.repeat 15 <|
                    ImageList.item
                        [ css "width" "calc(100% / 5 - 4.2px)"
                        , css "margin" "2px"
                        ]
                        [ ImageList.imageAspectContainer []
                            [ ImageList.divImage
                                [ css "background-color" "black"
                                ]
                                []
                            ]
                        ]
                )
            ]
        , content =
            [ styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Standard Image List with Text Protection" ]
            , ImageList.view
                [ ImageList.withTextProtection
                , cs "standard-image-list"
                ]
                (List.map
                    (\url ->
                        ImageList.item []
                            [ ImageList.imageAspectContainer []
                                [ ImageList.image
                                    [ ImageList.src url ]
                                    []
                                ]
                            , ImageList.supporting []
                                [ ImageList.label [] [ text "Text label" ] ]
                            ]
                    )
                    standardImages
                )
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Masonry Image List" ]
            , ImageList.view
                [ ImageList.masonry
                , cs "masonry-image-list"
                ]
                (List.map
                    (\url ->
                        ImageList.item []
                            [ ImageList.image
                                [ ImageList.src url
                                ]
                                []
                            , ImageList.label [] [ text "Text label" ]
                            ]
                    )
                    masonryImages
                )
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .hero-image-list {
      width: 300px;
      margin: 0;
    }

    .hero-image-list .mdc-image-list__item {
      width: calc(100% / 5 - 4.2px);
      margin: 2px;
    }

    .standard-image-list {
      max-width: 900px;
    }

    .standard-image-list .mdc-image-list__item {
      width: calc(100% / 5 - 4.2px);
      margin: 2px;
    }

    .standard-image-list .mdc-image-list__image-aspect-container {
      padding-bottom: 66.66667%;
    }

    .masonry-image-list {
      -webkit-column-count: 5;
      column-count: 5;
      -webkit-column-gap: 16px;
      column-gap: 16px;
      max-width: 900px;
    }

    .masonry-image-list .mdc-image-list__item {
      margin-bottom: 16px;
    }
    """


standardImages =
    [ "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/1.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/2.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/3.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/4.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/5.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/6.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/7.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/8.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/9.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/10.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/11.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/12.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/13.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/14.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/15.jpg"
    ]


masonryImages =
    [ "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/16.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/1.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/1.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/2.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/3.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/2.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/4.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/3.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/5.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/4.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/6.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/5.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/7.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/6.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/7.jpg"
    ]
