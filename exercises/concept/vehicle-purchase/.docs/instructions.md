# Instructions

In this exercise, you will write some code to help you prepare to buy a vehicle.

You have three tasks: determine if you will need to get a license; choose between two vehicles; and estimate the acceptable price for a used vehicle.

## 1. Determine if you will need a drivers license

Some kinds of vehicles require a drivers license to operate them.
Assume only vehicles containing `car` or `truck` require a license; everything else can be operated without a license.

Implement a "pattern {action}" pair that reads `needs_license` in the first field and the kind of vehicle in the second field, and prints "true" indicating whether you need a license for that kind of vehicle.
If you don't need a license, you don't need to print anything.

```sh
echo "needs_license,dumptruck" | gawk -F, -f vehicle-purchase.awk
# => true

echo "needs_license,bike" | gawk -F, -f vehicle-purchase.awk
# => (empty output)
```

## 2. Calculate an estimation for the price of a used vehicle

Now that you have made your decision, you want to make sure you get a fair price at the dealership.
Since you are interested in buying a used vehicle, the price depends on how old the vehicle is.
For a rough estimate, assume if the vehicle is less than 3 years old, it costs 80% of the original price it had when it was brand new.
If it is more than 10 years old, it costs 50%.
If the vehicle is at least 3 years old but not older than 10 years, it costs 70% of the original price.

Implement "pattern {action}" pairs that read "resell_price" in the first field, the original proce of the vehicle in the second field, and the age in the third field.
The action should print the estimated price.

```sh
echo "resell_price,1000,1" | gawk -F, -f vehicle-purchase.awk
# => 800

echo "resell_price,1000,5" | gawk -F, -f vehicle-purchase.awk
# => 700

echo "resell_price,1000,15" | gawk -F, -f vehicle-purchase.awk
# => 500
```
