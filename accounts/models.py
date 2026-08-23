from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    email = models.EmailField(
        "メールアドレス",
        unique=True,
    )

    icon = models.ImageField(
        "アイコン",
        upload_to="user_icons/", # BASE_DIR/media/user_icons/sample.png
        blank=True,
        null=True,
    )

    status_message = models.CharField(
        "ステータスメッセージ",
        max_length=100,
        blank=True,
    )

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = [
        "username"
    ]

    def __str__(self):
        return self.email

    class Meta:
        verbose_name = "ユーザー1" # 単数
        verbose_name_plural = "ユーザー2" # 複数