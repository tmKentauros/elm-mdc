module Demo.TopAppBar
    exposing
        ( Model
        , Msg(..)
        , defaultModel
        , subscriptions
        , update
        , view
        )

import Demo.Page as Page exposing (Page)
import Demo.Url as Url exposing (TopAppBarPage)
import Dict exposing (Dict)
import Html exposing (Html, div, p, text)
import Html.Attributes as Html
import Material
import Material.Button as Button
import Material.Options as Options exposing (Property, cs, css, styled, when)
import Material.TopAppBar as TopAppBar
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


view : (Msg m -> m) -> Page m -> Maybe TopAppBarPage -> Model m -> Html m
view lift page topAppBarPage model =
    case topAppBarPage of
        Just Url.StandardTopAppBar ->
            standardTopAppBar lift "top-app-bar-standard" model

        Just Url.FixedTopAppBar ->
            fixedTopAppBar lift "top-app-bar-fixed" model

        Just Url.DenseTopAppBar ->
            denseTopAppBar lift "top-app-bar-dense" model

        Just Url.ProminentTopAppBar ->
            prominentTopAppBar lift "top-app-bar-prominent" model

        Just Url.ShortTopAppBar ->
            shortTopAppBar lift "top-app-bar-short" model

        Just Url.ShortCollapsedTopAppBar ->
            shortCollapsedTopAppBar lift "top-app-bar-short-collapsed" model

        Nothing ->
            page.demoPage
                { title = "TopAppBar"
                , prelude =
                    [ """
                      Top App Bars are a container for items such as
                      application title, navigation icon, and action items.
                      """
                    ]
                , resources =
                    { materialGuidelines = ""
                    , documentation = ""
                    , sourceCode = ""
                    }
                , hero =
                    [ Html.div
                        [ Html.class "hero-top-app-bar" ]
                        [ TopAppBar.view (lift << Mdc)
                            "top-app-bar-hero-top-app-bar"
                            model.mdc
                            [ css "position" "static"
                            ]
                            [ TopAppBar.section
                                [ TopAppBar.alignStart
                                ]
                                [ TopAppBar.navigationIcon [] "menu"
                                , TopAppBar.title [] [ text "San Francisco" ]
                                ]
                            , TopAppBar.section
                                [ TopAppBar.alignEnd
                                ]
                                [ TopAppBar.actionItem [] "file_download"
                                , TopAppBar.actionItem [] "print"
                                , TopAppBar.actionItem [] "more_vert"
                                ]
                            ]
                        ]
                    ]
                , content =
                    [ Html.div
                        [ Html.class "demos-display" ]
                        [ iframe lift model "Standard" Url.StandardTopAppBar
                        , iframe lift model "Fixed" Url.FixedTopAppBar
                        , iframe lift model "Dense" Url.DenseTopAppBar
                        , iframe lift model "Prominent" Url.ProminentTopAppBar
                        , iframe lift model "Short" Url.ShortTopAppBar
                        , iframe lift
                            model
                            "Short - Always Collapsed"
                            Url.ShortCollapsedTopAppBar
                        ]
                    , Html.node "style"
                        [ Html.type_ "text/css" ]
                        [ text style ]
                    ]
                }


style : String
style =
    """
    .hero-top-app-bar {
      height: 64px;
      width: 80%;
      min-width: 300px;
    }

    .demos-display {
      display: -ms-flexbox;
      display: flex;
      -ms-flex-wrap: wrap;
      flex-wrap: wrap;
      min-height: 200px;
    }

    .demo {
      display: inline-block;
      -ms-flex: 1 1 45%;
      flex: 1 1 45%;
      -ms-flex-pack: distribute;
      justify-content: space-around;
      min-height: 200px;
      min-width: 400px;
      padding: 15px;
    }

    .frame {
      width: 100%;
      height: 200px;
    }
    """


iframe : (Msg m -> m) -> Model m -> String -> TopAppBarPage -> Html m
iframe lift model title topAppBarPage =
    let
        url =
            (++) "https://aforemny.github.io/elm-mdc/" <|
                Url.toString (Url.TopAppBar (Just topAppBarPage))
    in
    Html.div
        [ Html.class "demo" ]
        [ Html.div []
            [ styled Html.h3
                [ Typography.subtitle1 ]
                [ Html.a
                    [ Html.href url
                    , Html.target "_blank"
                    ]
                    [ text title ]
                ]
            ]
        , Html.div []
            [ Html.iframe
                [ Html.class "frame"
                , Html.src url
                , Html.title title
                ]
                []
            ]
        ]


topAppBarWrapper :
    List (Property c m)
    -> Html m
    -> Html m
topAppBarWrapper fixedAdjust topAppBar =
    styled Html.div
        [ cs "top-app-bar__frame"
        , Typography.typography
        ]
        [ Html.div
            [ Html.class "demo-frame" ]
            [ topAppBar
            , styled Html.div
                fixedAdjust
                [ body
                ]
            ]
        , Html.node "style"
            [ Html.type_ "text/css" ]
            [ text
                """
                .top-app-bar__frame {
                  height: 200vh;
                }
                """
            ]
        ]


standardTopAppBar : (Msg m -> m) -> Material.Index -> Model m -> Html m
standardTopAppBar lift index model =
    topAppBarWrapper
        [ TopAppBar.fixedAdjust ]
        (TopAppBar.view (lift << Mdc)
            index
            model.mdc
            []
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Standard" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )


fixedTopAppBar : (Msg m -> m) -> Material.Index -> Model m -> Html m
fixedTopAppBar lift index model =
    topAppBarWrapper
        [ TopAppBar.fixedAdjust ]
        (TopAppBar.view (lift << Mdc)
            index
            model.mdc
            [ TopAppBar.fixed
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Fixed" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )


denseTopAppBar : (Msg m -> m) -> Material.Index -> Model m -> Html m
denseTopAppBar lift index model =
    topAppBarWrapper
        [ TopAppBar.denseFixedAdjust ]
        (TopAppBar.view (lift << Mdc)
            index
            model.mdc
            [ TopAppBar.dense
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Dense" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )


prominentTopAppBar : (Msg m -> m) -> Material.Index -> Model m -> Html m
prominentTopAppBar lift index model =
    topAppBarWrapper
        [ TopAppBar.prominentFixedAdjust ]
        (TopAppBar.view (lift << Mdc)
            index
            model.mdc
            [ TopAppBar.prominent
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Prominent" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )


shortTopAppBar : (Msg m -> m) -> Material.Index -> Model m -> Html m
shortTopAppBar lift index model =
    topAppBarWrapper
        [ TopAppBar.fixedAdjust ]
        (TopAppBar.view (lift << Mdc)
            index
            model.mdc
            [ TopAppBar.short
            , TopAppBar.hasActionItem
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Short" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                ]
            ]
        )


shortCollapsedTopAppBar : (Msg m -> m) -> Material.Index -> Model m -> Html m
shortCollapsedTopAppBar lift index model =
    topAppBarWrapper
        [ TopAppBar.fixedAdjust ]
        (TopAppBar.view (lift << Mdc)
            index
            model.mdc
            [ TopAppBar.short
            , TopAppBar.collapsed
            , TopAppBar.hasActionItem
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                ]
            ]
        )


body : Html m
body =
    Html.div []
        (List.repeat 4 <|
            Html.p []
                [ text
                    """
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit,
                    sed do eiusmod tempor incididunt ut labore et dolore magna
                    aliqua. Ut enim ad minim veniam, quis nostrud exercitation
                    ullamco laboris nisi ut aliquip ex ea commodo consequat.
                    Duis aute irure dolor in reprehenderit in voluptate velit
                    esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
                    occaecat cupidatat non proident, sunt in culpa qui officia
                    deserunt mollit anim id est laborum.
                    """
                ]
        )
