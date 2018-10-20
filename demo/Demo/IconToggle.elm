module Demo.IconToggle exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Material
import Material.IconToggle as IconButton
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Typography as Typography
import Set exposing (Set)


type alias Model m =
    { mdc : Material.Model m
    , states : Set String
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    , states = Set.empty
    }


type Msg m
    = Mdc (Material.Msg m)
    | Toggle String


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model

        Toggle index ->
            let
                isOn =
                    Set.member index model.states

                newStates =
                    if isOn then
                        Set.remove index model.states
                    else
                        Set.insert index model.states
            in
            ( { model | states = newStates }, Cmd.none )


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Icon Button"
        , prelude =
            [ """
              Icons are appropriate for buttons that allow a user to take
              actions or make a selection, such as adding or removing a star to
              an item.
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
                    "icon-buttons-hero-icon-button"
              in
              IconButton.view (lift << Mdc)
                index
                model.mdc
                [ IconButton.icon
                    { on = "favorite", off = "favorite_border" }
                , Options.onClick (lift (Toggle index))
                , when (Set.member index model.states)
                    IconButton.on
                ]
                []
            ]
        , content =
            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Icon Button" ]
            , let
                index =
                    "icon-buttons-icon-button"
              in
              IconButton.view (lift << Mdc)
                index
                model.mdc
                [ IconButton.icon1 "wifi"
                ]
                []
            , styled Html.h3 [ Typography.subtitle1 ] [ text "Icon Toggle Button" ]
            , let
                index =
                    "icon-buttons-icon-toggle-button"
              in
              IconButton.view (lift << Mdc)
                index
                model.mdc
                [ IconButton.icon
                    { on = "favorite", off = "favorite_border" }
                , Options.onClick (lift (Toggle index))
                , when (Set.member index model.states)
                    IconButton.on
                ]
                []
            ]
        }



--    let
--        example options =
--            styled Html.div
--                (cs "example"
--                    :: css "margin" "24px"
--                    :: css "padding" "24px"
--                    :: css "display" "flex"
--                    :: css "flex-flow" "row wrap"
--                    :: css "align-content" "left"
--                    :: css "justify-content" "left"
--                    :: options
--                )
--
--        title options =
--            styled Html.h2
--                (css "margin-left" "0"
--                    :: css "margin-bottom" "0.8em"
--                    :: css "margin-top" "0.8em"
--                    :: css "font-size" "1.3em"
--                    :: options
--                )
--
--        toggleExample options =
--            styled Html.div
--                (cs "toggle-example"
--                    :: css "min-width" "240px"
--                    :: css "padding" "24px"
--                    :: css "margin" "24px"
--                    :: options
--                )
--
--        iconToggle idx options =
--            let
--                isOn =
--                    Dict.get idx model.iconToggles
--                        |> Maybe.withDefault False
--            in
--            IconToggle.view (lift << Mdc)
--                idx
--                model.mdc
--                (Options.onClick (lift (Toggle idx))
--                    :: when isOn IconToggle.on
--                    :: options
--                )
--    in
--    page.body "Icon toggles"
--        [ Page.hero []
--            [ let
--                isOn =
--                    Dict.get "icon-toggle-hero-icon-toggle" model.iconToggles
--                        |> Maybe.withDefault False
--              in
--              styled Html.div
--                [ cs "demo-wrapper"
--                , css "margin-left" "1rem"
--                ]
--                [ iconToggle "icon-toggle-hero-icon-toggle"
--                    [ IconToggle.label
--                        { on = "Remove from Fravorites"
--                        , off = "Add to Favorites"
--                        }
--                    , IconToggle.icon
--                        { on = "favorite"
--                        , off = "favorite_border"
--                        }
--                    ]
--                    []
--                ]
--            ]
--        , Html.node "style"
--            [ Html.type_ "text/css"
--            ]
--            [ text "@import url(\"https://opensource.keycdn.com/fontawesome/4.7.0/font-awesome.min.css\");" ]
--        , example []
--            [ let
--                isOn =
--                    Dict.get "icon-toggle-default-icon-toggle" model.iconToggles
--                        |> Maybe.withDefault False
--              in
--              toggleExample []
--                [ title [] [ text "Using Material Icons" ]
--                , styled Html.div
--                    [ css "margin-left" "1rem"
--                    ]
--                    [ iconToggle "icon-toggle-default-icon-toggle"
--                        [ IconToggle.label
--                            { on = "Remove from Fravorites"
--                            , off = "Add to Favorites"
--                            }
--                        , IconToggle.icon
--                            { on = "favorite"
--                            , off = "favorite_border"
--                            }
--                        ]
--                        []
--                    ]
--                , styled Html.p
--                    [ css "margin-top" "20px"
--                    , css "margin-bottom" "20px"
--                    ]
--                    [ text <|
--                        if isOn then
--                            "Favorited? yes"
--                        else
--                            "Favorited? no"
--                    ]
--                ]
--            , toggleExample []
--                [ title [] [ text "Using Font Awesome" ]
--                , styled Html.div
--                    [ css "margin-left" "1rem"
--                    ]
--                    [ iconToggle "icon-toggle-fa-icon-toggle"
--                        [ IconToggle.label
--                            { on = "Unstar this Icon"
--                            , off = "Star this Icon"
--                            }
--                        , IconToggle.icon
--                            { on = "fa-star"
--                            , off = "fa-star-o"
--                            }
--                        , IconToggle.className "fa"
--                        ]
--                        []
--                    ]
--                ]
--            , toggleExample []
--                [ title [] [ text "Disabled Icons" ]
--                , styled Html.div
--                    [ css "margin-left" "1rem"
--                    ]
--                    [ iconToggle "icon-toggle-disabled-icon-toggle"
--                        [ IconToggle.label
--                            { on = "Remove from Fravorites"
--                            , off = "Add to Favorites"
--                            }
--                        , IconToggle.icon
--                            { on = "favorite"
--                            , off = "favorite_border"
--                            }
--                        , IconToggle.disabled
--                        ]
--                        []
--                    ]
--                ]
--            ]
--        ]
