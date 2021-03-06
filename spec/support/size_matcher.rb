RSpec::Matchers.define :be_of_size do |expected|
  match do |actual|
    actual.size == expected
  end

  description do
    "have tasks totaling #{expected} points"
  end

  failure_message do |actual|
    "expected project \"#{actual.name}\" to have size #{expected}, was #{actual.size}"
  end

  failure_message_when_negated do |actual|
    "expected project \"#{actual.name}\" not to have size #{expected}"
  end
end
