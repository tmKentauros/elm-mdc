module Demo.Theme exposing (Model, Msg, defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Material
import Material.Button as Button
import Material.Card as Card
import Material.Checkbox as Checkbox
import Material.Dialog as Dialog
import Material.Elevation as Elevation
import Material.Fab as Fab
import Material.FormField as FormField
import Material.IconToggle as IconButton
import Material.LinearProgress as LinearProgress
import Material.Options as Options exposing (cs, css, styled, when)
import Material.RadioButton as RadioButton
import Material.Select as Select
import Material.Slider as Slider
import Material.Switch as Switch
import Material.Textfield as TextField
import Material.Theme as Theme
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
        { title = "Theme"
        , prelude =
            [ """
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            []
        , content =
            [ styled Html.h2
                [ Typography.headline4 ]
                [ text "Baseline Colors" ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ Typography.headline5
                    , cs "demo-component-section__heading"
                    ]
                    [ text "CSS Classes" ]
                , Html.div
                    [ Html.class "demo-theme-color-section" ]
                    [ Html.div
                        [ Html.class "demo-theme-color-section__row" ]
                        [ Html.fieldset
                            [ Html.class "demo-fieldset--color" ]
                            [ styled Html.legend
                                [ Typography.subtitle1 ]
                                [ text "Theme colors as text" ]
                            , Html.div
                                [ Html.class "demo-theme-color-group" ]
                                [ Html.div
                                    [ Html.class "demo-theme-color-swatches" ]
                                    [ styled Html.div
                                        [ cs "demo-theme-color-swatch"
                                        , cs "demo-theme-color-swatch--elevated"
                                        , Typography.body2
                                        , Theme.primary
                                        ]
                                        [ text "Primary"
                                        ]
                                    ]
                                , Html.div
                                    [ Html.class "demo-theme-color-swatches" ]
                                    [ styled Html.div
                                        [ cs "demo-theme-color-swatch"
                                        , cs "demo-theme-color-swatch--elevated"
                                        , Typography.body2
                                        , Theme.secondary
                                        ]
                                        [ text "Secondary"
                                        ]
                                    ]
                                ]
                            ]
                        , Html.fieldset
                            [ Html.class "demo-fieldset--color" ]
                            [ styled Html.legend
                                [ Typography.subtitle1 ]
                                [ text "Theme colors as background" ]
                            , Html.div
                                [ Html.class "demo-theme-color-group" ]
                                [ Html.div
                                    [ Html.class "demo-theme-color-swatches" ]
                                    [ styled Html.div
                                        [ cs "demo-theme-color-swatch"
                                        , cs "demo-theme-color-swatch--elevated"
                                        , Theme.primaryBg
                                        , Theme.textPrimaryOnPrimary
                                        ]
                                        [ text "Primary" ]
                                    ]
                                , Html.div
                                    [ Html.class "demo-theme-color-swatches" ]
                                    [ styled Html.div
                                        [ cs "demo-theme-color-swatch"
                                        , cs "demo-theme-color-swatch--elevated"
                                        , Theme.secondaryBg
                                        , Theme.textPrimaryOnSecondary
                                        ]
                                        [ text "Secondary" ]
                                    ]
                                , Html.div
                                    [ Html.class "demo-theme-color-swatches" ]
                                    [ styled Html.div
                                        [ cs "demo-theme-color-swatch"
                                        , cs "demo-theme-color-swatch--elevated"
                                        , Theme.background
                                        , Theme.textPrimaryOnBackground
                                        ]
                                        [ text "Secondary" ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                , Html.div
                    [ Html.class "demo-theme-color-section" ]
                    [ Html.div
                        [ Html.class "demo-theme-color-section__row" ]
                        [ Html.fieldset
                            [ Html.class "demo-fieldset--color" ]
                            [ styled Html.legend
                                [ Typography.subtitle1 ]
                                [ text "Text on background" ]
                            , Html.div
                                [ Html.class "demo-theme-color-group" ]
                                [ styled Html.div
                                    [ cs "demo-theme-text-row"
                                    , Typography.body2
                                    , Theme.background
                                    ]
                                    [ styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textPrimaryOnBackground
                                        ]
                                        [ text "Primary" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textSecondaryOnBackground
                                        ]
                                        [ text "Secondary" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textHintOnBackground
                                        ]
                                        [ text "Hint" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textDisabledOnBackground
                                        ]
                                        [ text "Disabled" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style material-icons"
                                        , Theme.textIconOnBackground
                                        ]
                                        [ text "favorite" ]
                                    ]
                                ]
                            ]
                        ]
                    , Html.div
                        [ Html.class "demo-theme-color-section__row" ]
                        [ Html.fieldset
                            [ Html.class "demo-fieldset--color" ]
                            [ styled Html.legend
                                [ Typography.subtitle1 ]
                                [ text "Text on primary" ]
                            , Html.div
                                [ Html.class "demo-theme-color-group" ]
                                [ styled Html.div
                                    [ cs "demo-theme-text-row"
                                    , Typography.body2
                                    , Theme.primaryBg
                                    ]
                                    [ styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textPrimaryOnPrimary
                                        ]
                                        [ text "Primary" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style material-icons"
                                        , Theme.textIconOnPrimary
                                        ]
                                        [ text "favorite" ]
                                    ]
                                ]
                            ]
                        , Html.fieldset
                            [ Html.class "demo-fieldset--color" ]
                            [ styled Html.legend
                                [ Typography.subtitle1 ]
                                [ text "Text on secondary" ]
                            , Html.div
                                [ Html.class "demo-theme-color-group" ]
                                [ styled Html.div
                                    [ cs "demo-theme-text-row"
                                    , Typography.body2
                                    , Theme.secondaryBg
                                    ]
                                    [ styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textPrimaryOnSecondary
                                        ]
                                        [ text "Primary" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style material-icons"
                                        , Theme.textIconOnSecondary
                                        ]
                                        [ text "favorite" ]
                                    ]
                                ]
                            ]
                        ]
                    , Html.div
                        [ Html.class "demo-theme-color-section__row" ]
                        [ Html.fieldset
                            [ Html.class "demo-fieldset--color" ]
                            [ styled Html.legend
                                [ Typography.subtitle1 ]
                                [ text "Text on user-defined light background" ]
                            , Html.div
                                [ Html.class "demo-theme-color-group" ]
                                [ styled Html.div
                                    [ cs "demo-theme-text-row"
                                    , cs "demo-theme-bg--custom-light"
                                    , Typography.body2
                                    ]
                                    [ styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textPrimaryOnLight
                                        ]
                                        [ text "Primary" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textSecondaryOnLight
                                        ]
                                        [ text "Secondary" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textHintOnLight
                                        ]
                                        [ text "Hint" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textDisabledOnLight
                                        ]
                                        [ text "Disabled" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style material-icons"
                                        , Theme.textIconOnLight
                                        ]
                                        [ text "favorite" ]
                                    ]
                                ]
                            ]
                        , Html.fieldset
                            [ Html.class "demo-fieldset--color" ]
                            [ styled Html.legend
                                [ Typography.subtitle1 ]
                                [ text "Text on user-defined dark background" ]
                            , Html.div
                                [ Html.class "demo-theme-color-group" ]
                                [ styled Html.div
                                    [ cs "demo-theme-text-row"
                                    , cs "demo-theme-bg--custom-dark"
                                    , Typography.body2
                                    ]
                                    [ styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textPrimaryOnDark
                                        ]
                                        [ text "Primary" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textSecondaryOnDark
                                        ]
                                        [ text "Secondary" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textHintOnDark
                                        ]
                                        [ text "Hint" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style"
                                        , Theme.textDisabledOnDark
                                        ]
                                        [ text "Disabled" ]
                                    , styled Html.span
                                        [ cs "demo-theme-text-style material-icons"
                                        , Theme.textIconOnDark
                                        ]
                                        [ text "favorite" ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            , styled Html.h2
                [ Typography.headline4 ]
                [ text "Baseline Component Stickersheet" ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Button" ]
                , Html.fieldset
                    [ Html.class "demo-fieldset--button" ]
                    [ styled Html.legend
                        [ Typography.subtitle1 ]
                        [ text "Enabled" ]
                    , Html.div []
                        [ Button.view (lift << Mdc)
                            "theme-button"
                            model.mdc
                            [ Button.ripple ]
                            [ text "Text" ]
                        , Button.view (lift << Mdc)
                            "theme-raised-button"
                            model.mdc
                            [ Button.ripple
                            , Button.raised
                            ]
                            [ text "Raised" ]
                        , Button.view (lift << Mdc)
                            "theme-outlined-button"
                            model.mdc
                            [ Button.ripple
                            , Button.outlined
                            ]
                            [ text "Outlined" ]
                        ]
                    , styled Html.legend
                        [ Typography.subtitle1 ]
                        [ text "Disabled" ]
                    , Html.div []
                        [ Button.view (lift << Mdc)
                            "theme-button"
                            model.mdc
                            [ Button.ripple
                            , Button.disabled
                            ]
                            [ text "Text" ]
                        , Button.view (lift << Mdc)
                            "theme-raised-button"
                            model.mdc
                            [ Button.ripple
                            , Button.raised
                            , Button.disabled
                            ]
                            [ text "Raised" ]
                        , Button.view (lift << Mdc)
                            "theme-outlined-button"
                            model.mdc
                            [ Button.ripple
                            , Button.outlined
                            , Button.disabled
                            ]
                            [ text "Outlined" ]
                        ]
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Card" ]
                , Html.div
                    [ Html.class "demo-card-wrapper" ]
                    [ Card.view []
                        [ Card.media
                            [ Card.aspect16To9
                            , Card.backgroundImage "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/2.jpg"
                            ]
                            []
                        , Card.actions []
                            [ Card.actionButtons []
                                [ Button.view (lift << Mdc)
                                    "theme-card-action-button-read"
                                    model.mdc
                                    [ Card.actionButton
                                    , Button.ripple
                                    ]
                                    [ text "Read"
                                    ]
                                , Button.view (lift << Mdc)
                                    "theme-card-action-button-bookmark"
                                    model.mdc
                                    [ Card.actionButton
                                    , Button.ripple
                                    ]
                                    [ text "Bookmark"
                                    ]
                                ]
                            , Card.actionIcons []
                                [ IconButton.view (lift << Mdc)
                                    "theme-card-action-icon-favorite"
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
                                    "theme-card-action-icon-share"
                                    model.mdc
                                    [ Card.actionIcon
                                    , IconButton.icon { on = "share", off = "share" }
                                    , IconButton.label { on = "Share", off = "Share" }
                                    ]
                                    []
                                , IconButton.view (lift << Mdc)
                                    "theme-card-action-icon-more-options"
                                    model.mdc
                                    [ Card.actionIcon
                                    , IconButton.icon { on = "more_vert", off = "more_vert" }
                                    , IconButton.label { on = "More options", off = "More options" }
                                    ]
                                    []
                                ]
                            ]
                        ]
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Checkbox" ]
                , Html.div
                    [ Html.class "demo-checkbox-row" ]
                    [ FormField.view
                        [ cs "demo-checkbox-wrapper" ]
                        [ Checkbox.view (lift << Mdc)
                            "theme-enabled-checkbox"
                            model.mdc
                            [ Checkbox.checked False ]
                            []
                        , Html.label
                            [ Html.for "theme-enabled-checkbox"
                            ]
                            [ text "Enabled" ]
                        ]
                    , FormField.view
                        [ cs "demo-checkbox-wrapper" ]
                        [ Checkbox.view (lift << Mdc)
                            "theme-indeterminate-checkbox"
                            model.mdc
                            []
                            []
                        , Html.label
                            [ Html.for "theme-indeterminate-checkbox"
                            ]
                            [ text "Indeterminate" ]
                        ]
                    , FormField.view
                        [ cs "demo-checkbox-wrapper" ]
                        [ Checkbox.view (lift << Mdc)
                            "theme-disabled-checkbox"
                            model.mdc
                            [ Checkbox.checked False
                            , Checkbox.disabled
                            ]
                            []
                        , Html.label
                            [ Html.for "theme-disabled-checkbox"
                            ]
                            [ text "Disabled" ]
                        ]
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Dialog" ]
                , Dialog.view (lift << Mdc)
                    "theme-dialog"
                    model.mdc
                    [ cs "demo-dialog"
                    , cs "mdc-dialog--open"
                    ]
                    [ Dialog.surface []
                        [ Dialog.header []
                            [ styled Html.h3
                                [ Dialog.title ]
                                [ text "Fire photon torpedoes?" ]
                            ]
                        , Dialog.body []
                            [ text "Shields at 60% and falling, captain." ]
                        , Dialog.footer []
                            [ Button.view (lift << Mdc)
                                "theme-dialog__button-cancel"
                                model.mdc
                                [ Button.ripple
                                , Dialog.cancel
                                ]
                                [ text "Relay that order" ]
                            , Button.view (lift << Mdc)
                                "theme-dialog__button-accept"
                                model.mdc
                                [ Button.ripple
                                , Dialog.accept
                                ]
                                [ text "Make it so" ]
                            ]
                        ]
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Drawer" ]
                , styled Html.p
                    [ Typography.body1 ]
                    [ text "Tap the menu icon ("
                    , Html.i
                        [ Html.class "material-icons demo-drawer-toggle" ]
                        [ text "menu" ]
                    , text ") in the toolbar at the top of the page to open the drawer."
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Floating Action Button (FAB)" ]
                , Html.fieldset []
                    [ Html.div
                        [ Html.class "demo-fab-row" ]
                        [ Html.div
                            [ Html.class "demo-fab-tile" ]
                            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Default" ]
                            , Fab.view (lift << Mdc)
                                "fabs-standard-fab"
                                model.mdc
                                [ Fab.ripple ]
                                "favorite_border"
                            ]
                        , Html.div
                            [ Html.class "demo-fab-tile" ]
                            [ styled Html.h3 [ Typography.subtitle1 ] [ text "Mini" ]
                            , Fab.view (lift << Mdc)
                                "fabs-mini-fab"
                                model.mdc
                                [ Fab.ripple
                                , Fab.mini
                                ]
                                "favorite_border"
                            ]
                        ]
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Icon Button Toggle" ]
                , Html.div
                    [ Html.class "demo-icon-button-row" ]
                    [ styled Html.div
                        [ cs "demo-icon-button-tile"
                        , Elevation.z2
                        ]
                        [ styled Html.h3
                            [ Typography.subtitle1 ]
                            [ text "Enabled" ]
                        , IconButton.view (lift << Mdc)
                            "theme-icon-button"
                            model.mdc
                            [ IconButton.icon
                                { on = "favorite", off = "favorite_border" }
                            ]
                            []
                        ]
                    , styled Html.div
                        [ cs "demo-icon-button-tile"
                        , Elevation.z2
                        ]
                        [ styled Html.h3
                            [ Typography.subtitle1 ]
                            [ text "Disabled" ]
                        , IconButton.view (lift << Mdc)
                            "theme-disabled-icon-button"
                            model.mdc
                            [ IconButton.icon
                                { on = "favorite", off = "favorite_border" }
                            , IconButton.disabled
                            ]
                            []
                        ]
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Linear Progress" ]
                , Html.figure
                    [ Html.class "demo-linear-progress-row" ]
                    [ styled Html.figcaption
                        [ Typography.subtitle1 ]
                        [ text "Indeterminate" ]
                    , LinearProgress.view [ LinearProgress.indeterminate ] []
                    ]
                , Html.figure
                    [ Html.class "demo-linear-progress-row" ]
                    [ styled Html.figcaption
                        [ Typography.subtitle1 ]
                        [ text "Buffer" ]
                    , LinearProgress.view [ LinearProgress.buffered 0.5 0.75 ] []
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Radio Buttons" ]
                , Html.figure
                    [ Html.class "demo-radio-group" ]
                    [ FormField.view
                        [ cs "demo-radio-form-field" ]
                        [ RadioButton.view (lift << Mdc)
                            "theme-radio-1"
                            model.mdc
                            []
                            []
                        , Html.label
                            [ Html.for "theme-radio-1"
                            ]
                            [ text "Enabled 1" ]
                        ]
                    , FormField.view
                        [ cs "demo-radio-form-field" ]
                        [ RadioButton.view (lift << Mdc)
                            "theme-radio-2"
                            model.mdc
                            []
                            []
                        , Html.label
                            [ Html.for "theme-radio-2"
                            ]
                            [ text "Enabled 2" ]
                        ]
                    , FormField.view
                        [ cs "demo-radio-form-field" ]
                        [ RadioButton.view (lift << Mdc)
                            "theme-disabled-radio-1"
                            model.mdc
                            [ RadioButton.disabled ]
                            []
                        , Html.label
                            [ Html.for "theme-disabled-radio-2"
                            ]
                            [ text "Disabled 1" ]
                        ]
                    , FormField.view
                        [ cs "demo-radio-form-field" ]
                        [ RadioButton.view (lift << Mdc)
                            "theme-disabled-radio-2"
                            model.mdc
                            [ RadioButton.disabled ]
                            []
                        , Html.label
                            [ Html.for "theme-disabled-radio-2"
                            ]
                            [ text "Disabled 2" ]
                        ]
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Select" ]
                , Select.view (lift << Mdc)
                    "theme-select"
                    model.mdc
                    [ Select.label "Fruit" ]
                    (List.map
                        (\label ->
                            Select.option [ Select.value label ] [ text label ]
                        )
                        [ "Apple"
                        , "Orange"
                        , "Banana"
                        ]
                    )
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Slider" ]
                , Slider.view (lift << Mdc)
                    "theme-slider"
                    model.mdc
                    [ Slider.trackMarkers
                    , Slider.min 0
                    , Slider.max 100
                    ]
                    []
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Switch" ]
                , Html.fieldset
                    [ Html.class "demo-switch-wrapper" ]
                    [ FormField.view []
                        [ Switch.view (lift << Mdc)
                            "theme-switch"
                            model.mdc
                            []
                            []
                        , styled Html.label
                            [ Options.for "theme-switch" ]
                            [ text "off/on" ]
                        ]
                    ]
                , Html.fieldset
                    [ Html.class "demo-switch-wrapper" ]
                    [ FormField.view []
                        [ Switch.view (lift << Mdc)
                            "theme-disabled-switch"
                            model.mdc
                            [ Switch.disabled ]
                            []
                        , styled Html.label
                            [ Options.for "theme-switch" ]
                            [ text "disabled" ]
                        ]
                    ]
                ]
            , Html.section
                [ Html.class "demo-component-section" ]
                [ styled Html.h3
                    [ cs "demo-component-section__heading"
                    , Typography.headline5
                    ]
                    [ text "Text Field" ]
                , Html.figure
                    [ Html.class "demo-text-field-wrapper" ]
                    [ TextField.view (lift << Mdc)
                        "theme-text-field"
                        model.mdc
                        [ TextField.label "Name (optional)" ]
                        []
                    ]
                , Html.figure
                    [ Html.class "demo-text-field-wrapper" ]
                    [ TextField.view (lift << Mdc)
                        "theme-required-text-field"
                        model.mdc
                        [ TextField.label "Email (required)"
                        , TextField.required
                        ]
                        []
                    ]
                , Html.figure
                    [ Html.class "demo-text-field-wrapper" ]
                    [ TextField.view (lift << Mdc)
                        "theme-outlined-text-field"
                        model.mdc
                        [ TextField.label "Outlined"
                        , TextField.outlined
                        ]
                        []
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
    :root {
      --mdc-theme-primary: #fcb8ab;
      --mdc-theme-secondary: #feeae6;
      --mdc-theme-background: #ffffff;
      --mdc-theme-surface: #fffbfa;
      --mdc-theme-error: #b00020;
      --mdc-theme-on-primary: #442b2d;
      --mdc-theme-on-secondary: #442c2e;
      --mdc-theme-on-surface: #442c2e;
      --mdc-theme-on-error: #fff;
      --mdc-theme-text-primary-on-background: rgba(0, 0, 0, 0.87);
      --mdc-theme-text-secondary-on-background: rgba(0, 0, 0, 0.54);
      --mdc-theme-text-hint-on-background: rgba(0, 0, 0, 0.38);
      --mdc-theme-text-disabled-on-background: rgba(0, 0, 0, 0.38);
      --mdc-theme-text-icon-on-background: rgba(0, 0, 0, 0.38);
      --mdc-theme-text-primary-on-light: rgba(0, 0, 0, 0.87);
      --mdc-theme-text-secondary-on-light: rgba(0, 0, 0, 0.54);
      --mdc-theme-text-hint-on-light: rgba(0, 0, 0, 0.38);
      --mdc-theme-text-disabled-on-light: rgba(0, 0, 0, 0.38);
      --mdc-theme-text-icon-on-light: rgba(0, 0, 0, 0.38);
      --mdc-theme-text-primary-on-dark: white;
      --mdc-theme-text-secondary-on-dark: rgba(255, 255, 255, 0.7);
      --mdc-theme-text-hint-on-dark: rgba(255, 255, 255, 0.5);
      --mdc-theme-text-disabled-on-dark: rgba(255, 255, 255, 0.5);
      --mdc-theme-text-icon-on-dark: rgba(255, 255, 255, 0.5);
    }

    fieldset {
      margin: 0;
      padding: 0;
      border: 0;
    }

    section.example {
      margin: 24px;
      padding: 24px;
    }

    section.example h2 {
      margin-left: 0;
    }

    figure {
      margin-left: 0;
      margin-right: 0;
    }

    .demo-main {
      padding: 24px;
    }

    .demo-component-section {
      position: relative;
    }

    .demo-component-section + .demo-component-section {
      margin-top: 48px;
    }

    .demo-component-section::before {
      content: "";
      display: block;
      position: absolute;
      top: -16px;
      left: -16px;
      right: -16px;
      bottom: -16px;
      z-index: -1;
      background: #fbc02d;
      opacity: 0;
      -webkit-transition: opacity 1s;
      -o-transition: opacity 1s;
      transition: opacity 1s;
    }

    .demo-theme-color-section + .demo-theme-color-section {
      margin-top: 36px;
    }

    .demo-theme-color-section__row {
      display: -ms-flexbox;
      display: flex;
      -ms-flex-wrap: wrap;
      flex-wrap: wrap;
    }

    .demo-fieldset--color {
      margin-right: 36px;
    }

    .demo-theme-color-group {
      padding: 16px 0;
    }

    .demo-theme-color-swatches {
      display: -ms-inline-flexbox;
      display: inline-flex;
      -ms-flex-direction: column;
      flex-direction: column;
      margin-right: 16px;
    }

    .demo-theme-color-swatch {
      -webkit-box-shadow: 0px 2px 1px -1px rgba(0, 0, 0, 0.2), 0px 1px 1px 0px rgba(0, 0, 0, 0.14), 0px 1px 3px 0px rgba(0, 0, 0, 0.12);
      box-shadow: 0px 2px 1px -1px rgba(0, 0, 0, 0.2), 0px 1px 1px 0px rgba(0, 0, 0, 0.14), 0px 1px 3px 0px rgba(0, 0, 0, 0.12);
      display: inline-block;
      -webkit-box-sizing: border-box;
      box-sizing: border-box;
      width: 150px;
      height: 50px;
      line-height: 50px;
      text-align: center;
      margin-bottom: 8px;
      border-radius: 4px;
    }

    .demo-theme-bg--custom-light {
      background-color: #dddddd;
    }

    .demo-theme-bg--custom-dark {
      background-color: #1d1d1d;
    }

    .demo-theme-text-row {
      display: -ms-inline-flexbox;
      display: inline-flex;
      -webkit-box-sizing: border-box;
      box-sizing: border-box;
      padding: 16px;
      border: 1px solid #f0f0f0;
      -ms-flex-align: center;
      align-items: center;
      -ms-flex-direction: column;
      flex-direction: column;
    }

    @media (min-width: 768px) {
      .demo-theme-text-row {
        -ms-flex-direction: row;
        flex-direction: row;
       }
     }

    .demo-theme-text-style {
      padding: 0 16px;
    }

    .demo-fieldset--button .mdc-button {
      margin-right: 10px;
    }

    .demo-fieldset--button + .demo-fieldset--button {
      margin-top: 16px;
    }

    .demo-card-wrapper {
      display: inline-block;
      margin: 0 24px 24px 0;
      vertical-align: top;
    }

    .demo-checkbox-row {
      display: -ms-flexbox;
      display: flex;
      -ms-flex-wrap: wrap;
      flex-wrap: wrap;
      -ms-flex-align: center;
      align-items: center;
     }

    .demo-checkbox-wrapper {
      margin-right: 10px;
    }

    .demo-checkbox-wrapper + .demo-checkbox-toggle-button {
      margin-left: 20px;
    }

    .demo-dialog {
      position: relative;
      -ms-flex-pack: start;
      justify-content: flex-start;
      z-index: auto;
    }

    .demo-drawer-toggle {
      vertical-align: middle;
      cursor: pointer;
    }

    .demo-fab-row {
      display: -ms-flexbox;
      display: flex;
      -ms-flex-wrap: wrap;
      flex-wrap: wrap;
     }

    .demo-fab {
      margin: 16px 0 0 0;
    }

    .demo-fab-tile {
      margin: 0 48px 1em 0;
    }

    .demo-fab-tile__title {
      font-weight: 500;
    }

    .demo-fab-tile__snippet {
      height: 2em;
    }

    .mdc-icon-button {
      display: -ms-inline-flexbox;
      display: inline-flex;
    }

    .demo-icon-button-toggle {
      color: #fcb8ab;
      color: var(--mdc-theme-primary, #fcb8ab);
    }

    .demo-icon-button-row {
      display: -ms-flexbox;
      display: flex;
      -ms-flex-wrap: wrap;
      flex-wrap: wrap;
     }

    .demo-icon-button-tile {
      width: 200px;
      margin: 0 10px 10px 0;
      padding: 20px;
      border-radius: 5px;
      text-align: center;
    }

    .demo-linear-progress-row {
      margin: 32px 0;
    }

    .demo-linear-progress-row + .demo-linear-progress-row {
      margin-top: 64px;
    }

    .demo-radio-group {
      display: inline-block;
      margin: 0 24px 24px 0;
    }

    .demo-radio-form-field {
      margin-right: 8px;
    }

    .demo-switch-wrapper {
      display: inline-block;
      margin: 16px 16px 0 0;
    }

    .demo-figure--tab-bar + .demo-figure--tab-bar {
      margin-top: 36px;
    }

    .demo-tab-bar {
      margin: 0;
    }

    .demo-text-field-wrapper {
      display: inline-block;
      margin: 16px 16px 0 0;
    }
    """
