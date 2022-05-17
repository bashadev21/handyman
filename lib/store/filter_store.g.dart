// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStore on FilterStoreBase, Store {
  final _$providerIdAtom = Atom(name: 'FilterStoreBase.providerId');

  @override
  List<int> get providerId {
    _$providerIdAtom.reportRead();
    return super.providerId;
  }

  @override
  set providerId(List<int> value) {
    _$providerIdAtom.reportWrite(value, super.providerId, () {
      super.providerId = value;
    });
  }

  final _$handymanIdAtom = Atom(name: 'FilterStoreBase.handymanId');

  @override
  List<int> get handymanId {
    _$handymanIdAtom.reportRead();
    return super.handymanId;
  }

  @override
  set handymanId(List<int> value) {
    _$handymanIdAtom.reportWrite(value, super.handymanId, () {
      super.handymanId = value;
    });
  }

  final _$ratingIdAtom = Atom(name: 'FilterStoreBase.ratingId');

  @override
  List<int> get ratingId {
    _$ratingIdAtom.reportRead();
    return super.ratingId;
  }

  @override
  set ratingId(List<int> value) {
    _$ratingIdAtom.reportWrite(value, super.ratingId, () {
      super.ratingId = value;
    });
  }

  final _$isPriceMaxAtom = Atom(name: 'FilterStoreBase.isPriceMax');

  @override
  String get isPriceMax {
    _$isPriceMaxAtom.reportRead();
    return super.isPriceMax;
  }

  @override
  set isPriceMax(String value) {
    _$isPriceMaxAtom.reportWrite(value, super.isPriceMax, () {
      super.isPriceMax = value;
    });
  }

  final _$isPriceMinAtom = Atom(name: 'FilterStoreBase.isPriceMin');

  @override
  String get isPriceMin {
    _$isPriceMinAtom.reportRead();
    return super.isPriceMin;
  }

  @override
  set isPriceMin(String value) {
    _$isPriceMinAtom.reportWrite(value, super.isPriceMin, () {
      super.isPriceMin = value;
    });
  }

  final _$addToProviderListAsyncAction =
      AsyncAction('FilterStoreBase.addToProviderList');

  @override
  Future<void> addToProviderList({required int prodId}) {
    return _$addToProviderListAsyncAction
        .run(() => super.addToProviderList(prodId: prodId));
  }

  final _$removeFromProviderListAsyncAction =
      AsyncAction('FilterStoreBase.removeFromProviderList');

  @override
  Future<void> removeFromProviderList({required int prodId}) {
    return _$removeFromProviderListAsyncAction
        .run(() => super.removeFromProviderList(prodId: prodId));
  }

  final _$addToHandymanListAsyncAction =
      AsyncAction('FilterStoreBase.addToHandymanList');

  @override
  Future<void> addToHandymanList({required int prodId}) {
    return _$addToHandymanListAsyncAction
        .run(() => super.addToHandymanList(prodId: prodId));
  }

  final _$removeFromHandymanListAsyncAction =
      AsyncAction('FilterStoreBase.removeFromHandymanList');

  @override
  Future<void> removeFromHandymanList({required int prodId}) {
    return _$removeFromHandymanListAsyncAction
        .run(() => super.removeFromHandymanList(prodId: prodId));
  }

  final _$addToRatingIdAsyncAction =
      AsyncAction('FilterStoreBase.addToRatingId');

  @override
  Future<void> addToRatingId({required int prodId}) {
    return _$addToRatingIdAsyncAction
        .run(() => super.addToRatingId(prodId: prodId));
  }

  final _$removeFromRatingIdAsyncAction =
      AsyncAction('FilterStoreBase.removeFromRatingId');

  @override
  Future<void> removeFromRatingId({required int prodId}) {
    return _$removeFromRatingIdAsyncAction
        .run(() => super.removeFromRatingId(prodId: prodId));
  }

  final _$FilterStoreBaseActionController =
      ActionController(name: 'FilterStoreBase');

  @override
  void setMaxPrice(String val) {
    final _$actionInfo = _$FilterStoreBaseActionController.startAction(
        name: 'FilterStoreBase.setMaxPrice');
    try {
      return super.setMaxPrice(val);
    } finally {
      _$FilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMinPrice(String val) {
    final _$actionInfo = _$FilterStoreBaseActionController.startAction(
        name: 'FilterStoreBase.setMinPrice');
    try {
      return super.setMinPrice(val);
    } finally {
      _$FilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
providerId: ${providerId},
handymanId: ${handymanId},
ratingId: ${ratingId},
isPriceMax: ${isPriceMax},
isPriceMin: ${isPriceMin}
    ''';
  }
}
