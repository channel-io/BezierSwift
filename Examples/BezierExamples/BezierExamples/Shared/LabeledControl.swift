import SwiftUI

struct LabeledSegmented<T: Hashable & RawRepresentable>: View where T.RawValue == String {
  let label: String
  @Binding var selection: T
  let options: [T]

  var body: some View {
    HStack(alignment: .center, spacing: 8) {
      Text(self.label)
        .font(.caption)
        .foregroundStyle(.secondary)
        .frame(width: 72, alignment: .leading)
      Picker(self.label, selection: self.$selection) {
        ForEach(self.options, id: \.self) { option in
          Text(option.rawValue).tag(option)
        }
      }
      .pickerStyle(.segmented)
    }
  }
}
