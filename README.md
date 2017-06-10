# Feapper
Feapper the Feature Flipper

# Installation

#### CocoaPods
```
pod 'Feapper'
```

#### Carthage
```
github "MonkeyDMat/Feapper"
```

# Usage

First register to get notified of feature status changes

```
Feapper.shared.register(delegate: self, featureId: "FeatureName")
```

Then implements the FeapperDelegate protocol :

```
func featureEnabled(featureId:String)
func featureDisabled(featureId:String)
```

NOTE: the delegate is called immediately after you register, and when the status changes 

 The feature status can be setup in a json file (see : 'sources/Feapper/FeapperTests/featuresConfig.json')

You can also turn a feature on/off programatically by calling :

```
Feapper.shared.flipOn(featureId: "FeatureName")
Feapper.shared.flipOff(featureId: "FeatureName")
```