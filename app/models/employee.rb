class Employee < ApplicationRecord
  belongs_to :position
  belongs_to :superior, class_name: "Employee", optional:true
  has_many :subordinates, class_name: "Employee", foreign_key:"superior_id"
  belongs_to :employment_status
  before_destroy :handle_superior_destruction

  private
  def handle_superior_destruction
    if !self.subordinates.empty?
      self.subordinates.each do |e|
        e.superior_id=nil
        e.save
      end
    end
  end
  
  
end
