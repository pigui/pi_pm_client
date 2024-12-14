import 'package:pi_pm_client/core/common/entities/user.dart';
import 'package:pi_pm_client/features/auth/data/models/user_model.dart';

class UserMapper {
  User toDomain(UserModel userModel) {
    return User(
        id: userModel.id,
        email: userModel.email,
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        role: UserRole(value: userModel.role.value),
        status: UserStatus(value: userModel.status.value),
        createdAt: userModel.createdAt,
        updatedAt: userModel.updatedAt);
  }
}
