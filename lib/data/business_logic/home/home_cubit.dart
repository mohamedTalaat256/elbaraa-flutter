import 'package:elbaraa/data/business_logic/home/home_state.dart';
import 'package:elbaraa/data/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  List<Object> materials = [];

  HomeCubit(this.homeRepository) : super(HomeInitial());

Future<Object> homeData() async {
  var response = await homeRepository.homeData();
  if (response.success) {
    emit(HomeDataLoaded(response.data!));
    return response.data!;
  } else {
    return {};
  }
}
}
