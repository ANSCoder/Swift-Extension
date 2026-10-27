//  Example.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

/// Every demo in the catalog. Adding a case means adding a demo view with a static `info`.
@MainActor
enum Example: CaseIterable {
    case scrollToTop
    case scrollToView
    case paging
    case scrollPosition
    case pinnedHeaders
    case scrollTransition
    case dismissOnTap
    case scrollDismisses
    case focusChain
    case keyboardToolbar
    case stackAlignment
    case grid
    case adaptiveGrid
    case viewThatFits
    case flowLayout
    case markdownText
    case scaledMetric
    case numericText
    case dateStyles
    case springBasic
    case implicitAnimation
    case transitions
    case matchedGeometry
    case phaseAnimator
    case keyframeAnimator
    case symbolEffect
    case shake
    case dragSpring
    case timelineView
    case shimmer
    case confetti
    case radarPulse
    case drawCheckmark
    case liquidWave
    case progressRing
    case cardStack
    case auroraGradient
    case slidingSegments
    case tiltCard
    case barChart
    case lineAreaChart
    case donutChart
    case stackedBars
    case scrollableChart
    case kpiCards
    case cardStyle
    case conditionalModifiers
    case loadingOverlay
    case errorAlert
    case sizeAndAppear
    case snapshotView
    case validation
    case dateHelpers
    case stringHelpers
    case numberHelpers
    case urlHelpers

    var info: ExampleInfo {
        switch self {
        case .scrollToTop: ScrollToTopDemo.info
        case .scrollToView: ScrollToViewDemo.info
        case .paging: PagingDemo.info
        case .scrollPosition: ScrollPositionDemo.info
        case .pinnedHeaders: PinnedHeadersDemo.info
        case .scrollTransition: ScrollTransitionDemo.info
        case .dismissOnTap: DismissOnTapDemo.info
        case .scrollDismisses: ScrollDismissesDemo.info
        case .focusChain: FocusChainDemo.info
        case .keyboardToolbar: KeyboardToolbarDemo.info
        case .stackAlignment: StackAlignmentDemo.info
        case .grid: GridDemo.info
        case .adaptiveGrid: AdaptiveGridDemo.info
        case .viewThatFits: ViewThatFitsDemo.info
        case .flowLayout: FlowLayoutDemo.info
        case .markdownText: MarkdownTextDemo.info
        case .scaledMetric: ScaledMetricDemo.info
        case .numericText: NumericTextDemo.info
        case .dateStyles: DateStylesDemo.info
        case .springBasic: SpringBasicDemo.info
        case .implicitAnimation: ImplicitAnimationDemo.info
        case .transitions: TransitionsDemo.info
        case .matchedGeometry: MatchedGeometryDemo.info
        case .phaseAnimator: PhaseAnimatorDemo.info
        case .keyframeAnimator: KeyframeAnimatorDemo.info
        case .symbolEffect: SymbolEffectDemo.info
        case .shake: ShakeDemo.info
        case .dragSpring: DragSpringDemo.info
        case .timelineView: TimelineViewDemo.info
        case .shimmer: ShimmerDemo.info
        case .confetti: ConfettiDemo.info
        case .radarPulse: RadarPulseDemo.info
        case .drawCheckmark: DrawCheckmarkDemo.info
        case .liquidWave: LiquidWaveDemo.info
        case .progressRing: ProgressRingDemo.info
        case .cardStack: CardStackDemo.info
        case .auroraGradient: AuroraGradientDemo.info
        case .slidingSegments: SlidingSegmentsDemo.info
        case .tiltCard: TiltCardDemo.info
        case .barChart: BarChartDemo.info
        case .lineAreaChart: LineAreaChartDemo.info
        case .donutChart: DonutChartDemo.info
        case .stackedBars: StackedBarsDemo.info
        case .scrollableChart: ScrollableChartDemo.info
        case .kpiCards: KpiCardsDemo.info
        case .cardStyle: CardStyleDemo.info
        case .conditionalModifiers: ConditionalModifiersDemo.info
        case .loadingOverlay: LoadingOverlayDemo.info
        case .errorAlert: ErrorAlertDemo.info
        case .sizeAndAppear: SizeAndAppearDemo.info
        case .snapshotView: SnapshotViewDemo.info
        case .validation: ValidationDemo.info
        case .dateHelpers: DateHelpersDemo.info
        case .stringHelpers: StringHelpersDemo.info
        case .numberHelpers: NumberHelpersDemo.info
        case .urlHelpers: URLHelpersDemo.info
        }
    }

    /// One sentence telling the reader what to do on the demo screen.
    var playHint: String {
        switch self {
        case .scrollToTop: "Tap Play to glide to the last row. Top and Bottom jump on demand."
        case .scrollToView: "Tap Play to jump so row 20 lands at the top."
        case .paging: "Swipe sideways, or tap Play to snap to the next page."
        case .scrollPosition: "Scroll the list and watch the live row number. Play jumps to row 20."
        case .pinnedHeaders: "Scroll the list: each header sticks until the next one pushes it away."
        case .scrollTransition: "Scroll slowly. Cards near the edges shrink and fade."
        case .dismissOnTap: "Tap Play to open the keyboard, then tap empty space to dismiss it."
        case .scrollDismisses: "Tap Play to focus the field, then drag the list down to dismiss the keyboard."
        case .focusChain: "Tap Play, then press Next on the keyboard to move through the fields."
        case .keyboardToolbar: "Tap Play, then use the Done button above the keyboard."
        case .stackAlignment: "Tap Play to flip the alignment between leading and trailing."
        case .grid: "Tap Play to raise the quantity. The total column updates."
        case .adaptiveGrid: "Tap Play to grow the cells until the grid reflows."
        case .viewThatFits: "Drag the slider narrow: the layout switches from a row to a column."
        case .flowLayout: "Tap Play to shuffle the chips. They re-wrap to fit."
        case .markdownText: "Tap Play to switch the highlight color of the styled run."
        case .scaledMetric: "Tap Play to toggle an accessibility text size. Icon and text scale together."
        case .numericText: "Tap +1, −1 or Play. Digits roll like an odometer."
        case .dateStyles: "Tap Play to move the reference time back one hour per press."
        case .springBasic: "Tap Play. The ball overshoots, then settles."
        case .implicitAnimation: "Tap Play to morph shape, color and rotation together."
        case .transitions: "Tap Play to insert or remove the card with a custom transition."
        case .matchedGeometry: "Tap Play (or the stage) to morph the small dot into a large one."
        case .phaseAnimator: "Tap Play to launch the plane through three animation phases."
        case .keyframeAnimator: "Tap Play to make the figure jump along exact keyframes."
        case .symbolEffect: "Tap Play to bounce the heart and toggle the Wi-Fi wave."
        case .shake: "Tap Play to shake the field like a wrong password."
        case .dragSpring: "Drag the ball and let go: it springs home. Play throws it."
        case .timelineView: "The gear spins on its own. Tap Play to pause or resume."
        case .shimmer: "Tap Play to show a loading skeleton for two seconds."
        case .confetti: "Tap Play to fire a confetti burst."
        case .radarPulse: "Rings pulse outward on their own. Tap Play to pause or resume."
        case .drawCheckmark: "Tap Play to redraw the ring and the checkmark."
        case .liquidWave: "Tap Play to change the water level."
        case .progressRing: "Tap Play to set a new progress value."
        case .cardStack: "Swipe the top card left or right. Tap Play for a fresh deck."
        case .auroraGradient: "Colors drift on their own. Tap Play to change the palette."
        case .slidingSegments: "Tap a segment, or tap Play. The highlight slides between them."
        case .tiltCard: "Drag across the card to tilt it. Tap Play for an automatic sweep."
        case .barChart: "Touch and drag across the bars for details. Tap Play to load new data."
        case .lineAreaChart: "Touch and drag along the line for exact values. Tap Play to redraw it."
        case .donutChart: "Touch a segment to focus it. Tap Play to load new shares."
        case .stackedBars: "Switch between absolute and 100% stacking. Tap Play to load new data."
        case .scrollableChart: "Scroll the chart sideways through 90 days. Tap Play to jump to the start or end."
        case .kpiCards: "Tap Play to refresh every number and sparkline."
        case .cardStyle: "Tap Play to change the corner radius of the card and its border."
        case .conditionalModifiers: "Tap Play to flip every condition at once."
        case .loadingOverlay: "Tap Play to block the screen with a spinner for two seconds."
        case .errorAlert: "Tap Play to raise an alert from an optional message."
        case .sizeAndAppear: "Drag the slider or tap Play. The measured size updates live."
        case .snapshotView: "Tap Play to render the card into an image."
        case .validation: "Tap Play to fill valid values, or type your own."
        case .dateHelpers: "Pick a date or tap Play to jump to tomorrow."
        case .stringHelpers: "Edit the text, or tap Play to try a URL."
        case .numberHelpers: "Drag the slider or tap Play for a random value."
        case .urlHelpers: "Tap Play to append a query item to the URL."
        }
    }

    /// The live demo. `play` changes each time the user taps Play; demos react to it.
    @ViewBuilder
    func demo(play: Int) -> some View {
        switch self {
        case .scrollToTop: ScrollToTopDemo(play: play)
        case .scrollToView: ScrollToViewDemo(play: play)
        case .paging: PagingDemo(play: play)
        case .scrollPosition: ScrollPositionDemo(play: play)
        case .pinnedHeaders: PinnedHeadersDemo(play: play)
        case .scrollTransition: ScrollTransitionDemo(play: play)
        case .dismissOnTap: DismissOnTapDemo(play: play)
        case .scrollDismisses: ScrollDismissesDemo(play: play)
        case .focusChain: FocusChainDemo(play: play)
        case .keyboardToolbar: KeyboardToolbarDemo(play: play)
        case .stackAlignment: StackAlignmentDemo(play: play)
        case .grid: GridDemo(play: play)
        case .adaptiveGrid: AdaptiveGridDemo(play: play)
        case .viewThatFits: ViewThatFitsDemo(play: play)
        case .flowLayout: FlowLayoutDemo(play: play)
        case .markdownText: MarkdownTextDemo(play: play)
        case .scaledMetric: ScaledMetricDemo(play: play)
        case .numericText: NumericTextDemo(play: play)
        case .dateStyles: DateStylesDemo(play: play)
        case .springBasic: SpringBasicDemo(play: play)
        case .implicitAnimation: ImplicitAnimationDemo(play: play)
        case .transitions: TransitionsDemo(play: play)
        case .matchedGeometry: MatchedGeometryDemo(play: play)
        case .phaseAnimator: PhaseAnimatorDemo(play: play)
        case .keyframeAnimator: KeyframeAnimatorDemo(play: play)
        case .symbolEffect: SymbolEffectDemo(play: play)
        case .shake: ShakeDemo(play: play)
        case .dragSpring: DragSpringDemo(play: play)
        case .timelineView: TimelineViewDemo(play: play)
        case .shimmer: ShimmerDemo(play: play)
        case .confetti: ConfettiDemo(play: play)
        case .radarPulse: RadarPulseDemo(play: play)
        case .drawCheckmark: DrawCheckmarkDemo(play: play)
        case .liquidWave: LiquidWaveDemo(play: play)
        case .progressRing: ProgressRingDemo(play: play)
        case .cardStack: CardStackDemo(play: play)
        case .auroraGradient: AuroraGradientDemo(play: play)
        case .slidingSegments: SlidingSegmentsDemo(play: play)
        case .tiltCard: TiltCardDemo(play: play)
        case .barChart: BarChartDemo(play: play)
        case .lineAreaChart: LineAreaChartDemo(play: play)
        case .donutChart: DonutChartDemo(play: play)
        case .stackedBars: StackedBarsDemo(play: play)
        case .scrollableChart: ScrollableChartDemo(play: play)
        case .kpiCards: KpiCardsDemo(play: play)
        case .cardStyle: CardStyleDemo(play: play)
        case .conditionalModifiers: ConditionalModifiersDemo(play: play)
        case .loadingOverlay: LoadingOverlayDemo(play: play)
        case .errorAlert: ErrorAlertDemo(play: play)
        case .sizeAndAppear: SizeAndAppearDemo(play: play)
        case .snapshotView: SnapshotViewDemo(play: play)
        case .validation: ValidationDemo(play: play)
        case .dateHelpers: DateHelpersDemo(play: play)
        case .stringHelpers: StringHelpersDemo(play: play)
        case .numberHelpers: NumberHelpersDemo(play: play)
        case .urlHelpers: URLHelpersDemo(play: play)
        }
    }
}

extension Example: @MainActor Identifiable {
    var id: Self { self }
}
