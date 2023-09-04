data = ""

with open('day-01.txt', 'r') as file:
    data = file.read()

data = data.split('\n')

i = 0
calories = [0]
for d in data:
    if d == '':
        i+=1
        calories.append(0)
    else:
        calories[i] += int(d)

calories.sort(reverse=True)

print(calories[0])

result = 0
for j in range(0, 3):
    result += calories[j]

print(result)
