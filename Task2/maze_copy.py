with open("example_data.txt") as f:
    office_rooms = f.read().splitlines()


def find_route():
    current_room_index = 0
    current_row_index = 0

    horiz_len = len(office_rooms[0])
    vert_len = len(office_rooms)
    path = [office_rooms[0][current_room_index]]

    # print(office_rooms)


    while current_row_index != vert_len:
        current_room = office_rooms[current_row_index][current_room_index]
        
        
        if current_room_index+1 < horiz_len:
            next_room = office_rooms[current_row_index][current_room_index+1]
        
            next_room_r = office_rooms[current_row_index][current_room_index+2]
            next_room_b = office_rooms[current_row_index+1][current_room_index+1]

            right_option_1 = int(next_room) + int(next_room_r)
            right_option_2 = int(next_room) + int(next_room_b)
            right_option = int(next_room_b) + int(next_room_r)

            print ("current row:", office_rooms[current_row_index])
            print("current room:", current_room)
            print("next_room:", next_room)
            print("next room right", next_room_r)
            print("next room below:", next_room_b)
            print("right option right:", right_option_1)
            print("right option below:", right_option_2)
        
            
        if current_row_index+1 != vert_len:
            room_below = office_rooms[current_row_index+1][current_room_index]  
            room_below_r = office_rooms[current_row_index+1][current_room_index+1]
            room_below_b = office_rooms[current_row_index+2][current_room_index]
            below_option_1 = int(room_below) +int(room_below_r)
            below_option_2 = int(room_below)+int(room_below_b)
            # print("room below:", room_below)
            # print("room below right", room_below_r)
            # print("room below below:", room_below_b)
            # print("below option right", below_option_1)
            # print("below option below:", below_option_2)

            

            # breakpoint()
            

        
            if right_option > below_option_1 and right_option > below_option_2:
              #  print ("down")
                path.append(room_below)
                current_row_index+=1
                current_room = office_rooms[current_row_index][current_room_index]
            
            elif right_option < below_option_1 and right_option > below_option_2:
               # print("right")
                path.append(next_room)
                current_room_index+=1
                current_room = office_rooms[current_row_index][current_room_index]


            # if next_room < room_below:
            #     print("right")
            #     path.append(next_room)
            #     current_room_index+=1
            #     current_room = office_rooms[current_row_index][current_room_index]
            else:
                if next_room < room_below:
                  #  print("right")
                    path.append(next_room)
                    current_room_index+=1
                    current_room = office_rooms[current_row_index][current_room_index]

                elif room_below < next_room:
                   # print("down")
                    path.append(room_below)
                    current_row_index+=1
                    current_room = office_rooms[current_row_index][current_room_index]
                else:
                    # print("down")
                    path.append(room_below)
                    current_row_index+=1
                    current_room = office_rooms[current_row_index][current_room_index]
        else:
            current_row_index = vert_len
        print("path",path)


    result = 0
    for p in path:
        result+=int(p)
    print(result)


find_route()


# office_room_map = [
#     [1,1,6,3,7,5,1,7,4,2],
#     [1,3,8,1,3,7,3,6,7,2],
#     [2,1,3,6,5,1,1,3,2,8],
#     [3,6,9,4,9,3,1,5,6,9],
#     [7,4,6,3,4,1,7,1,1,1],
#     [1,3,1,9,1,2,8,1,3,7],
#     [1,3,5,9,9,1,2,4,2,1],
#     [3,1,2,5,4,2,1,6,3,9],
#     [1,2,9,3,1,3,8,5,2,1],
#     [2,3,1,1,9,4,4,5,8,1]
# ]

# print(office_room_map[0][2])