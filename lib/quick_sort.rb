class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = 0
    left = array[(pivot + 1)...array.length].select { |num| num < array[pivot] }
    right = array[(pivot + 1)...array.length].select { |num| num >= array[pivot] }

    return QuickSort.sort1(left) + [array[pivot]] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if length < 2

    pivot_idx = partition(array, start, length, &prc)

    left_len = pivot_idx - start
    right_len = length - (left_len + 1)
    sort2!(array, start, left_len, &prc)
    sort2!(array, pivot_idx + 1, right_len, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    # Selecting a random pivot
    # new_pivot = start + rand(length)
    # array[start], array[new_pivot] = array[new_pivot], array[start]

    partition = start + 1
    curr_num_idx = start + 1
    pivot = array[start]

    while curr_num_idx < (start + length)
      if prc.call(pivot, array[curr_num_idx]) > 0

        array[curr_num_idx], array[partition] = array[partition], array[curr_num_idx]
        partition += 1
      end
      curr_num_idx += 1
    end

    array[start], array[partition - 1] = array[partition - 1], array[start]
    partition - 1
  end
end
