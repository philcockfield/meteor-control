describe 'Control', ->
  afterEach -> Test.tearDown()

  it 'has a subset of properties from the context (instance)', (done) ->
    Test.insert 'foo', (instance) =>
      ctrl = instance.ctrl
      @try =>
          expect(ctrl.context).to.equal instance
          expect(ctrl.type).to.equal 'foo'
          expect(ctrl.uid).to.equal instance.uid
      done()


  it 'parent', (done) ->
    Test.insert 'deep', (instance) =>
      ctrl = instance.ctrl
      @try =>
          childCtrl = instance.children.myFoo
          expect(childCtrl.parent).to.equal ctrl
      done()


  it 'passes [el] method to [instance.find]', (done) ->
    Test.insert 'foo', (instance) =>
      ctrl = instance.ctrl
      count = 0
      selector = null
      instance.find = (s) ->
          count += 1
          selector = s

      @try =>
          ctrl.el('.foo')
          expect(count).to.equal 1
          expect(selector).to.equal '.foo'
      done()




describe 'Control: dispose', ->
  afterEach -> Test.tearDown()

  it 'is disposed when instance is disposed', (done) ->
    Test.insert 'foo', (instance) =>
      @try =>
          instance.dispose()
          expect(instance.isDisposed).to.equal true
          expect(instance.ctrl.isDisposed).to.equal true
      done()


  it 'disposes of instance', (done) ->
    Test.insert 'foo', (instance) =>
      ctrl = instance.ctrl
      @try =>
          ctrl.dispose()
          expect(instance.isDisposed).to.equal true
          expect(ctrl.isDisposed).to.equal true
          expect(Ctrl.ctrls[ctrl.uid]).to.equal undefined
      done()



describe 'Control: API', ->
  afterEach -> Test.tearDown()

  it 'copies API onto the [ctrl]', (done) ->
    Test.insert 'apiTest', (instance) =>
      ctrl = instance.ctrl
      @try =>
          expect(ctrl.myMethod().self).to.equal instance # Invoked with [context/instance] as [this].
          expect(ctrl.myProp()).to.equal 123 # Default value.
          ctrl.myProp('my value')
          expect(ctrl.myProp()).to.equal 'my value'
      done()


  it 'overwrites standard Ctrl API', (done) ->
    Test.insert 'apiTest', (instance) =>
      ctrl = instance.ctrl
      @try =>
          expect(ctrl.children()).to.equal 'my-children'
      done()




