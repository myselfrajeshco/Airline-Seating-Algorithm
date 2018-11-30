require_relative '../airline_seating'
# require 'pry'

describe AirlineSeating do
  describe 'method#initialize' do
    context 'check if the input arguments are valid or not' do
      describe 'method#validate_input' do
        context 'when input blank' do
          let(:lines) { [] }
          let!(:blank_message) { 'Please provide input: A 2D array and the Number of passengers!' }
          it "returns a proper validation message" do
            obj = AirlineSeating.new(lines)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(blank_message)
          end
        end

        context 'when either of the 2 inputs is blank' do
          let(:first_lines) { ["", "59"] }
          let!(:first_blank_message) { 'Please provide a 2D array as the first argument!' }
          let(:second_lines) { ["1,2,3", ""] }
          let!(:second_blank_message) { 'Please provide the Number of passengers as the second argument!' }

          it "returns a proper validation message when the first argument is blank" do
            obj = AirlineSeating.new(first_lines)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(first_blank_message)
          end

          it "returns a proper validation message when the second argument is blank" do
            obj = AirlineSeating.new(second_lines)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(second_blank_message)
          end
        end

        context 'when the 2D array is not valid' do
          let(:lines_first_arg_not_all_are_arrays) { ["[[3,2],2,[4],[3,4]]", "59"] }
          let!(:message_1) { 'The given array is not in 2D format!' }
          let(:lines_first_arg_not_all_arrays_with_xy_format) { ["[[3,2],[2],[4,3,4],[3,4]]", "59"] }
          let!(:message_2) { 'All the sub-arrays of the given 2D array are not of [x,y] format!' }
          let(:lines_first_arg_sub_arrays_with_zeros) { ["[[3,2],[2,0],[4,3],[3,4]]", "59"] }
          let!(:message_3) { "The sub-arrays are in [x,y] format but 'x' and 'y' should be NON-ZERO values!" }

          it "returns a proper validation message when any element of the given 2D array is not an array" do
            obj = AirlineSeating.new(lines_first_arg_not_all_are_arrays)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(message_1)
          end

          it "returns a proper validation message when any element of the given 2D array is not an array of [x,y] format" do
            obj = AirlineSeating.new(lines_first_arg_not_all_arrays_with_xy_format)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(message_2)
          end

          it "returns a proper validation message when any sub array element contain x or y values as zero" do
            obj = AirlineSeating.new(lines_first_arg_sub_arrays_with_zeros)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(message_3)
          end
        end

        context 'when the 2nd argument is not an integer' do
          let(:lines) { ["[[3,2],[2,5],[4,8],[3,4]]", "[59]"] }
          let!(:message) { 'The second argument should be a positive integer' }

          it "returns a proper validation message the 2nd argument is not an integer" do
            obj = AirlineSeating.new(lines)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(message)
          end
        end

        context 'when both the inputs are correct' do
          let(:lines) { ["[[3,2],[2,5],[4,8],[3,4]]", "59"] }

          it "returns no validation message" do
            obj = AirlineSeating.new(lines)
            expect(obj.message).to be_nil
          end
        end
      end
    end

    context 'check if the instance is getting initialized with the required attributes' do
      let(:lines) { ["[[3,2],[2,5],[4,8],[3,4]]", "59"] }
      let(:max_seats) { (3*2) + (2*5) + (4*8) + (3*4) }

      it "sets the maximum seats available" do
        obj = AirlineSeating.new(lines)
        expect(obj.max_seats).not_to be_nil
        expect(obj.max_seats).to equal(max_seats)
      end

      it "sets the passengers count" do
        obj = AirlineSeating.new(lines)
        expect(obj.passengers_count).not_to be_nil
        expect(obj.passengers_count).to equal(59)
      end
    end
  end

  describe 'method#arragement' do
    context 'allocation and arrangement of seats for the people waiting in the queue' do
      describe 'method#allocate_aisle_seats' do
        context 'allocating asile seats first' do
          let(:lines) { ["[[3,2],[4,3],[2,3],[3,4]]", "30"] }
          let(:aisle_seats) { (1..18).to_a }

          it "allocates the aisle seats in the correct order" do
            obj = AirlineSeating.new(lines)
            seating = obj.arrangement
            temp = seating.map { |x| x.map { |y| y.values_at(0,-1) unless y.nil? } }
            aisle_seats_array = temp.map { |x| x.flatten }.map { |x| x[1..x.size - 2] }.flatten.compact.map(&:to_i)
            expect(aisle_seats_array).to eql(aisle_seats)
          end
        end
      end

      describe 'method#allocate_window_seats' do
        context 'allocating windows seats next' do
          let(:lines) { ["[[3,2],[4,3],[2,3],[3,4]]", "30"] }
          let(:windows_seats) { (19..24).to_a }

          it "allocates the windows seats in the correct order" do
            obj = AirlineSeating.new(lines)
            seating = obj.arrangement
            temp = seating.map { |x| x.map { |y| y.values_at(0,-1) unless y.nil? } }
            window_seats_array = temp.map { |x| x.flatten }.map { |x| x.values_at(0,-1) }.flatten.compact.map(&:to_i)
            expect(window_seats_array).to eql(windows_seats)
          end
        end
      end

      describe 'method#allocate_center_seats' do
        context 'allocating center seats last' do
          let(:lines) { ["[[3,2],[4,3],[2,3],[3,4]]", "30"] }
          let(:center_seats) { (25..30).to_a }

          it "allocates the center seats in the correct order" do
            obj = AirlineSeating.new(lines)
            seating = obj.arrangement
            temp = seating.map { |x| x.map { |y| y[1..y.size-2] unless y.nil? } }
            center_seats_array = temp.flatten.reject { |x| x == 'XX' }.compact.map(&:to_i)
            expect(center_seats_array).to eql(center_seats)
          end
        end
      end
    end
  end
end
