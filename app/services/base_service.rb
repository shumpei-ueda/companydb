class BaseService
  include ActiveModel::Model

  # サービスを利用するクラスが呼び出すメソッド
  def provide()
    raise_validation_error if invalid?
    perform
  end

  private

  # サービスの処理（パラメータが正常な場合のみ実行されます）
  # 各サービスクラスではこのメソッドをoverrideして機能を実装します
  def perform()
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  # バリデーションエラー時、ActiveRecord::RecordInvalidを投げるためのメソッド
  def raise_validation_error()
    raise ActiveRecord::RecordInvalid.new(self)
  end
end