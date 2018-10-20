module Demo.Cards exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Material
import Material.Button as Button
import Material.Card as Card
import Material.Checkbox as Checkbox
import Material.FormField as FormField
import Material.Icon as Icon
import Material.IconToggle as IconButton
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Ripple as Ripple
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


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model


cardContents : (Msg m -> m) -> String -> Model m -> List (Html m)
cardContents lift index mdoel =
    [ styled Html.div
        [ cs "demo-card__primary" ]
        [ styled Html.h2
            [ Typography.headline6
            , cs "demo-card__title"
            ]
            [ text "Our Changing Planet" ]
        , styled Html.h3
            [ Typography.subtitle2
            , cs "demo-card__subtitle"
            ]
            [ text "by Kurt Wagner" ]
        ]
    , styled Html.div
        [ Typography.body2
        , cs "demo-card__secondary"
        ]
        [ text
            """
            Visit ten places on our planet that are undergoing the biggest
            changes today.
            """
        ]
    ]


cardMedia : (Msg m -> m) -> String -> Model m -> List (Html m)
cardMedia lift index model =
    [ Card.media
        [ Card.aspect16To9
        , Card.backgroundImage "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/2.jpg"
        ]
        []
    ]


cardActions : (Msg m -> m) -> String -> Model m -> Html m
cardActions lift index model =
    Card.actions []
        [ Card.actionButtons []
            [ Button.view (lift << Mdc)
                (index ++ "-action-button-read")
                model.mdc
                [ Card.actionButton
                , Button.ripple
                ]
                [ text "Read"
                ]
            , Button.view (lift << Mdc)
                (index ++ "-action-button-bookmark")
                model.mdc
                [ Card.actionButton
                , Button.ripple
                ]
                [ text "Bookmark"
                ]
            ]
        , Card.actionIcons []
            [ IconButton.view (lift << Mdc)
                (index ++ "-action-icon-favorite")
                model.mdc
                [ Card.actionIcon
                , IconButton.icon
                    { on = "favorite"
                    , off = "favorite_border"
                    }
                , IconButton.label
                    { on = "Remove from favorites"
                    , off = "Add to favorites"
                    }
                ]
                []
            , IconButton.view (lift << Mdc)
                (index ++ "-action-icon-share")
                model.mdc
                [ Card.actionIcon
                , IconButton.icon { on = "share", off = "share" }
                , IconButton.label { on = "Share", off = "Share" }
                ]
                []
            , IconButton.view (lift << Mdc)
                (index ++ "-action-icon-more-options")
                model.mdc
                [ Card.actionIcon
                , IconButton.icon { on = "more_vert", off = "more_vert" }
                , IconButton.label { on = "More options", off = "More options" }
                ]
                []
            ]
        ]


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Card"
        , prelude =
            [ """
              Cards contain content and actions about a single subject.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ let
                index =
                    "cards-hero-card"

                ripple =
                    Ripple.bounded (lift << Mdc)
                        (index ++ "__bounded-ripple")
                        model.mdc
                        []
              in
              Card.view
                [ cs "demo-card demo-card--hero" ]
                [ Card.primaryAction
                    [ ripple.interactionHandler
                    , ripple.properties
                    ]
                    (List.concat
                        [ cardMedia lift index model
                        , cardContents lift index model
                        , [ ripple.style ]
                        ]
                    )
                , cardActions lift index model
                ]
            ]
        , content =
            [ Html.div []
                [ let
                    index =
                        "card-example-card0"

                    ripple =
                        Ripple.bounded (lift << Mdc)
                            (index ++ "__bounded-ripple")
                            model.mdc
                            []
                  in
                  Card.view
                    [ cs "demo-card demo-card" ]
                    [ Card.primaryAction
                        [ ripple.interactionHandler
                        , ripple.properties
                        ]
                        (List.concat
                            [ cardMedia lift index model
                            , cardContents lift index model
                            , [ ripple.style ]
                            ]
                        )
                    ]
                ]
            , Html.div []
                [ let
                    index =
                        "card-example-card1"

                    ripple =
                        Ripple.bounded (lift << Mdc)
                            (index ++ "__bounded-ripple")
                            model.mdc
                            []
                  in
                  Card.view
                    [ cs "demo-card demo-card" ]
                    [ Card.primaryAction
                        [ ripple.interactionHandler
                        , ripple.properties
                        ]
                        (List.concat
                            [ cardContents lift index model
                            , [ ripple.style ]
                            ]
                        )
                    , cardActions lift index model
                    ]
                ]
            , Html.div []
                [ let
                    index =
                        "card-example-card2"

                    ripple =
                        Ripple.bounded (lift << Mdc)
                            (index ++ "__bounded-ripple")
                            model.mdc
                            []
                  in
                  Card.view
                    [ cs "demo-card demo-card--shaped" ]
                    [ Card.primaryAction
                        [ ripple.interactionHandler
                        , ripple.properties
                        ]
                        (List.concat
                            [ cardContents lift index model
                            , [ ripple.style ]
                            ]
                        )
                    , cardActions lift index model
                    ]
                ]
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .demo-card {
      width: 350px;
      margin: 48px 0;
    }

    .demo-card--hero {
      margin: 0;
    }

    .demo-card--shaped {
      border-radius: 24px 8px;
    }

    .demo-card__primary {
      padding: 1rem;
    }

    .demo-card__title {
      margin: 0;
    }

    .demo-card__subtitle {
      margin: 0;
    }

    .demo-card__secondary {
      padding: 0 1rem 8px;
    }

    .demo-card__subtitle,
    .demo-card__secondary {
      color: rgba(0,0,0,.54);
      color: var(--mdc-theme-text-secondary-on-background,rgba(0,0,0,.54));
    }
    """
