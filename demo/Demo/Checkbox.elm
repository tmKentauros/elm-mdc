module Demo.Checkbox exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes as Html
import Json.Decode as Json
import Material
import Material.Button as Button
import Material.Checkbox as Checkbox
import Material.FormField as FormField
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model m =
    { mdc : Material.Model m
    , states : Dict Material.Index (Maybe Bool)
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    , states =
        Dict.fromList
            [ ( "checkbox-hero-checkbox-checked", Just True )
            , ( "checkbox-hero-checkbox-unchecked", Just False )
            , ( "checkbox-demo-checkbox-unchecked", Just False )
            , ( "checkbox-demo-checkbox-indeterminate", Nothing )
            , ( "checkbox-demo-checkbox-checked", Just True )
            ]
    }


type Msg m
    = Mdc (Material.Msg m)
    | CheckboxClicked Material.Index


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model

        CheckboxClicked index ->
            let
                state =
                    Maybe.withDefault Nothing (Dict.get index model.states)

                newState =
                    case state of
                        Nothing ->
                            Just True

                        Just False ->
                            Just True

                        Just True ->
                            Just False

                newStates =
                    Dict.insert index newState model.states
            in
            ( { model | states = newStates }, Cmd.none )


checkbox : (Msg m -> m) -> String -> Model m -> Html m
checkbox lift index model =
    let
        state =
            Maybe.withDefault Nothing (Dict.get index model.states)
    in
    Checkbox.view (lift << Mdc)
        index
        model.mdc
        [ cs "demo-checkbox"
        , Options.onClick (lift (CheckboxClicked index))
        , case state of
            Nothing ->
                Options.nop

            Just checked ->
                Checkbox.checked checked
        ]
        []


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Checkbox"
        , prelude =
            [ """
              Checkboxes allow the user to select multiple options from a set.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ Html.div []
                [ checkbox lift "checkbox-hero-checkbox-checked" model
                , checkbox lift "checkbox-hero-checkbox-unchecked" model
                ]
            ]
        , content =
            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Unchecked" ]
            , checkbox lift "checkbox-demo-checkbox-unchecked" model
            , styled Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
            , checkbox lift "checkbox-demo-checkbox-indeterminate" model
            , styled Html.h3 [ Typography.subtitle1 ] [ text "Checked" ]
            , checkbox lift "checkbox-demo-checkbox-checked" model
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .demo-checkbox {
      margin: 8px 16px;
    }
    """
