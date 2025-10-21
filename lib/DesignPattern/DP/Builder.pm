package DesignPattern::DP::Builder;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::Deep;
    require MealBuilder;
    my $mealBuilder = MealBuilder->new;
    my $vegMeal = $mealBuilder->prepareVegMeal;
    is_deeply($vegMeal->getItems,
          [ ['Veg Burger', 'Wrapper', 10], ['Coke', 'Bottle', 12] ]);
    is($vegMeal->getCost, 22);
    my $nonVegMeal = $mealBuilder->prepareNonVegMeal;
    is_deeply($nonVegMeal->getItems,
          [ ['Chicken Burger', 'Wrapper', 20], ['Pepsi', 'Bottle', 14] ]);
    is($nonVegMeal->getCost, 34);
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require MealBuilder;
            my $mealBuilder = MealBuilder->new;
            my $vegMeal = $mealBuilder->prepareVegMeal;
            $vegMeal->getItems;
            $vegMeal->getCost;
            my $nonVegMeal = $mealBuilder->prepareNonVegMeal;
            $nonVegMeal->getItems;
            $nonVegMeal->getCost;
        }
    });
}

1;
