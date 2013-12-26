class StateService
  def self.all
    states = State.all
    StateDecorator::decorate(states)
  end
end