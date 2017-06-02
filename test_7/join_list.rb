require 'set'
require 'pry-byebug'

class JoinList
  class << self
    def simple(list1, list2)
      list1.dup.merge(list2).sort
    end

    def hard(list1, list2)
      list1 = list1.to_a
      list2 = list2.to_a
      new_list = []

      if list1.length < list2.length
        list1, list2 = list2, list1
      end

      while list1.length > 0
        l1 = list1.shift
        while list2.length > 0
          l2 = list2.shift

          if l1 == l2 && !exist_values?(new_list, l1, nil)
            new_list.push l1
            break
          elsif l1 < l2 && !exist_values?(new_list, l1, l2)
            new_list.push l1
            list2.unshift l2
            break
          elsif !exist_values?(new_list, l1, l2)
            new_list.push l2
            list1.unshift l1
            break
          end
        end

        if list2.length == 0 && !exist_values?(new_list, l1, nil)
          new_list.push l1
        end
      end

      while list2.length > 0
        new_list.push list2.shift
      end

      new_list
    end

    def exist_values?(list, v1, v2)
      list = list.dup
      while list.length > 0
        value = list.shift
        return true if value == v1 || v2 && value == v2
      end

      false
    end
  end
end


# Сложность:
# проход по списку - O(N)
# удаление/вставка из начала списка - O(N)
# добавление в конец списка - O(1)
# поиск по списку - в худшем случае - O(N)
# проход по обоим спискам в худшем случае - O(N^2)
# проход1(проход2(поиск, вставка, удаление)) + проход2(добавление в конец)
# Итого: O((N * N * N * N * N) + N*1) ~= O(N^6)
