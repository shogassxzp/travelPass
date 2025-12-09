import SwiftUI

struct CarriersListScreen: View {
    // MARK: - Environment Properties

    @Environment(\.dismiss) private var dismiss

    // MARK: - ViewModel

    @StateObject private var viewModel: CarriersListViewModel

    // MARK: - Route

    let from: String
    let to: String

    // MARK: - Initalizer

    init(from: String, to: String) {
        self.from = from
        self.to = to
        _viewModel = StateObject(
            wrappedValue: CarriersListViewModel(fromText: from, toText: to)
        )
    }

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack(spacing: 0) {
                headerView

                if viewModel.segments.isEmpty {
                    emptyStateView
                } else {
                    carriersListView
                }

                filtersButton
            }
            .navigationDestination(for: CarriersListViewModel.CarrierRoute.self) { route in
                routeDestination(for: route)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
            }
            .task {
                await viewModel.loadSegments()
            }
        }
    }

    // MARK: - Subviews

    private var headerView: some View {
        Text("\(from) → \(to)")
            .font(.system(size: 24, weight: .bold))
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }

    private var carriersListView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.segments) { segment in
                    CarrierCell(segment: segment)
                        .onTapGesture {
                            if let carrier = segment.thread.carrier {
                                viewModel.showCarrierDetails(carrier)
                            }
                        }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
    }

    private var filtersButton: some View {
        Button(action: {
            viewModel.showFilters()
        }) {
            Text("Уточнить время")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.yUniversalWhite)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: 60)
        }
        .background(.yBlue)
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }

    private var backButton: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.left")
                .foregroundStyle(.yBlack)
        }
    }

    // MARK: - Navigation

    @ViewBuilder
    private func routeDestination(for route: CarriersListViewModel.CarrierRoute) -> some View {
        switch route {
        case .filters:
            FiltersScreen()
        case let .carrierDetails(carrier):
            CarrierDetailsScreen(carrier: carrier)
        }
    }
}
