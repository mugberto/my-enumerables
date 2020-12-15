require './enumerables'

describe Enumerable do
    describe '#my_each' do
        it "should return an enumerator object if block is not given" do
            obj = [1,2,4,5]
            expect(obj.my_each.class).to eql(Enumerator)
        end
        it "should return number of  key and a value pair in a hash if block is given" do
            obj = {man: 'Martin', age: 47}
            expect(obj.my_each {|k,v| p "#{k}, #{v}"}).to eql(2)
        end
        it "should return number of  array items in an array if block is given" do
            obj = [1,2,4,5]
            expect(obj.my_each {|n| p "n is : #{n}"}).to eql(4)
        end
    end

    describe '#my_each_with_index' do
        it "should return an enumerator object if block is not given" do
            obj = [1,2,3,4,5]
            expect(obj.my_each_with_index.class).to eql(Enumerator)
        end
        it "should return number of  array items in an array if block is given" do
            obj = [1,2,3,4,5]
            expect(obj.my_each_with_index {|n| p "n is : #{n}"}).to eql(5)
        end
    end

    describe "#my_select" do
        it "should return an enumerator object if block is not given" do
            obj = [1,2,3,4,5]
            expect(obj.my_select.class).to eql(Enumerator)
        end
        it "should return an array containing all the elements that meet the given condition of the block" do
            obj = [1,2,3,4,5,6,7,8,9,10]
            expect(obj.my_select {even).to eql([2,4,6,8,10])
        end

    end


end
