# フォームオブジェクト
class StacksTag

  include ActiveModel::Model
  attr_accessor :text, :date, :work_time_id, :achieved, :user_id,  :name,:tag_id, :stack_id

  with_options presence: true do
    validates :text, length: { maximum: 20 }
    validates :date
    validates :name
  end

    #// stackがすでに保存されているものか、新規のものかで、PUTとPATCHを分ける
    delegate :persisted?, to: :stack

    # initializeでFormオブジェクトの値を初期化し、更新の際はdefault_attributesを呼び出す設定
    def initialize(attributes = nil, stack: Stack.new)
      @stack = stack
      attributes ||= default_attributes
      super(attributes)
    end  
  

  def save(tag_list)

    ActiveRecord::Base.transaction do
      @stack.update(text: text, date: date, work_time_id: work_time_id, achieved: achieved, user_id: user_id)
      current_tags = @stack.tags.pluck(:name) unless @stack.tags.nil?
      old_tags = current_tags - tag_list
      new_tags = tag_list - current_tags

      old_tags.each do |old_name|
        @stack.tags.delete Tag.find_by(name: old_name)
      end

      new_tags.each do |new_name|
        stack_tag = Tag.find_or_create_by(name: new_name)
        @stack.tags << stack_tag
        stack_tag_relation = StackTag.where(stack_id: @stack.id, tag_id: stack_tag.id).first_or_initialize
        stack_tag_relation.update(stack_id: @stack.id, tag_id: stack_tag.id)
      end      
    end
  end

  def to_model
    stack
  end

  private

  attr_reader :stack, :tag

  def default_attributes
    {
      text: stack.text,
      date: stack.date,
      name: stack.tags.pluck(:name).join(',')
    }
  end
end