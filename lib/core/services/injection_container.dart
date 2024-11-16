import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pi_pm_client/core/common/app/singletons/user_logged.dart';
import 'package:pi_pm_client/core/common/singletons/network.dart';
import 'package:pi_pm_client/core/environments/environment.dart';
import 'package:pi_pm_client/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pi_pm_client/features/auth/data/mappers/user_mapper.dart';
import 'package:pi_pm_client/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pi_pm_client/features/auth/domain/repositories/auth_respository.dart';
import 'package:pi_pm_client/features/auth/domain/usecases/login.dart';
import 'package:pi_pm_client/features/auth/domain/usecases/register.dart';
import 'package:pi_pm_client/features/auth/presentation/app/adapters/auth_bloc.dart';

part 'injection_container.main.dart';
