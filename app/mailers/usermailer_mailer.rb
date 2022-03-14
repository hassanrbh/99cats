class UsermailerMailer < ApplicationMailer
    default :from => "from@example.com"

    def welcome_email(user)
        @user = user
        @url = "https://example.com/login"
        mail(to: user.email, subject: "Welcome to our website!")
    end
end
