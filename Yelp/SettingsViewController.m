//
//  SettingsViewController.m
//  Yelp
//
//  Created by Nizha Shree Seenivasan on 10/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SettingsViewController.h"
# import "CategoriesTableViewCell.h"
# import "DropDownTableViewCell.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate, CategoriesTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *FilterTableview;
@property (nonatomic, readonly) NSDictionary* filters;
@property (nonatomic, strong) NSArray* categories;
@property BOOL IsViewAllCategories;
@property BOOL IsViewAllDistances;
@property int selectedDistanceIndex;
@property (nonatomic, strong) NSArray* distances;
- (void) initializeCategories;

@property (nonatomic, strong) NSMutableSet* selectedCategories;
@property BOOL isSelectedDeal;

@end

@implementation SettingsViewController
- (NSDictionary * )filters {
    NSMutableDictionary* filters = [NSMutableDictionary dictionary];
    if(self.selectedCategories.count > 0){
        NSMutableArray* names = [NSMutableArray array];
        for(NSDictionary* category in self.selectedCategories)
                [names addObject:category[@"code"]];
//        NSString* categoryFilter = [names componentsJoinedByString:@","];
        [filters setObject:names forKey:@"category_filter"];
    }
    NSArray* distances_set = @[@0, @0.3, @1, @5];
    if(_isSelectedDeal == true)
        [filters setObject:@"YES" forKey:@"deal_filter"];
    else
        [filters setObject:@"NO" forKey:@"deal_filter"];
    
    [filters setObject:distances_set[_selectedDistanceIndex] forKey:@"radius_filter"];
    return filters;
}
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.selectedCategories = [NSMutableSet set];
        self.selectedDistanceIndex = 0;
        [self initializeCategories];
        [self initializeDistances];
    }
    return self;
}

- (void)initializeDistances{
    self.distances = @[@"Auto", @"0.3 mile", @"1 mile", @"5 mile"];
}
- (void) initializeCategories{
    self.categories = @[@{@"name": @"Afghan", @"code": @"afghani"},
                            @{@"name": @"African", @"code": @"african"},
                            @{@"name": @"American, New", @"code": @"newamerican"},
                            @{@"name": @"American, Traditional", @"code": @"tradamerican"},
                            @{@"name": @"Arabian", @"code": @"arabian"},
                            @{@"name": @"Argentine", @"code": @"argentine"},
                            @{@"name": @"Armenian", @"code": @"armenian"},
                            @{@"name": @"Asian Fusion", @"code": @"asianfusion"},
                            @{@"name": @"Asturian", @"code": @"asturian"},
                            @{@"name": @"Australian", @"code": @"australian"},
                            @{@"name": @"Austrian", @"code": @"austrian"},
                            @{@"name": @"Baguettes", @"code": @"baguettes"},
                            @{@"name": @"Bangladeshi", @"code": @"bangladeshi"},
                            @{@"name": @"Barbeque", @"code": @"bbq"},
                            @{@"name": @"Basque", @"code": @"basque"},
                            @{@"name": @"Bavarian", @"code": @"bavarian"},
                            @{@"name": @"Beer Garden", @"code": @"beergarden"},
                            @{@"name": @"Beer Hall", @"code": @"beerhall"},
                            @{@"name": @"Beisl", @"code": @"beisl"},
                            @{@"name": @"Belgian", @"code": @"belgian"},
                            @{@"name": @"Bistros", @"code": @"bistros"},
                            @{@"name": @"Black Sea", @"code": @"blacksea"},
                            @{@"name": @"Brasseries", @"code": @"brasseries"},
                            @{@"name": @"Brazilian", @"code": @"brazilian"},
                            @{@"name": @"Breakfast & Brunch", @"code": @"breakfast_brunch"},
                            @{@"name": @"British", @"code": @"british"},
                            @{@"name": @"Buffets", @"code": @"buffets"},
                            @{@"name": @"Bulgarian", @"code": @"bulgarian"},
                            @{@"name": @"Burgers", @"code": @"burgers"},
                            @{@"name": @"Burmese", @"code": @"burmese"},
                            @{@"name": @"Cafes", @"code": @"cafes"},
                            @{@"name": @"Cafeteria", @"code": @"cafeteria"},
                            @{@"name": @"Cajun/Creole", @"code": @"cajun"},
                            @{@"name": @"Cambodian", @"code": @"cambodian"},
                            @{@"name": @"Canadian", @"code": @"New)"},
                            @{@"name": @"Canteen", @"code": @"canteen"},
                            @{@"name": @"Caribbean", @"code": @"caribbean"},
                            @{@"name": @"Catalan", @"code": @"catalan"},
                            @{@"name": @"Chech", @"code": @"chech"},
                            @{@"name": @"Cheesesteaks", @"code": @"cheesesteaks"},
                            @{@"name": @"Chicken Shop", @"code": @"chickenshop"},
                            @{@"name": @"Chicken Wings", @"code": @"chicken_wings"},
                            @{@"name": @"Chilean", @"code": @"chilean"},
                            @{@"name": @"Chinese", @"code": @"chinese"},
                            @{@"name": @"Comfort Food", @"code": @"comfortfood"},
                            @{@"name": @"Corsican", @"code": @"corsican"},
                            @{@"name": @"Creperies", @"code": @"creperies"},
                            @{@"name": @"Cuban", @"code": @"cuban"},
                            @{@"name": @"Curry Sausage", @"code": @"currysausage"},
                            @{@"name": @"Cypriot", @"code": @"cypriot"},
                            @{@"name": @"Czech", @"code": @"czech"},
                            @{@"name": @"Czech/Slovakian", @"code": @"czechslovakian"},
                            @{@"name": @"Danish", @"code": @"danish"},
                            @{@"name": @"Delis", @"code": @"delis"},
                            @{@"name": @"Diners", @"code": @"diners"},
                            @{@"name": @"Dumplings", @"code": @"dumplings"},
                            @{@"name": @"Eastern European", @"code": @"eastern_european"},
                            @{@"name": @"Ethiopian", @"code": @"ethiopian"},
                            @{@"name": @"Fast Food", @"code": @"hotdogs"},
                            @{@"name": @"Filipino", @"code": @"filipino"},
                            @{@"name": @"Fish & Chips", @"code": @"fishnchips"},
                            @{@"name": @"Fondue", @"code": @"fondue"},
                            @{@"name": @"Food Court", @"code": @"food_court"},
                            @{@"name": @"Food Stands", @"code": @"foodstands"},
                            @{@"name": @"French", @"code": @"french"},
                            @{@"name": @"French Southwest", @"code": @"sud_ouest"},
                            @{@"name": @"Galician", @"code": @"galician"},
                            @{@"name": @"Gastropubs", @"code": @"gastropubs"},
                            @{@"name": @"Georgian", @"code": @"georgian"},
                            @{@"name": @"German", @"code": @"german"},
                            @{@"name": @"Giblets", @"code": @"giblets"},
                            @{@"name": @"Gluten-Free", @"code": @"gluten_free"},
                            @{@"name": @"Greek", @"code": @"greek"},
                            @{@"name": @"Halal", @"code": @"halal"},
                            @{@"name": @"Hawaiian", @"code": @"hawaiian"},
                            @{@"name": @"Heuriger", @"code": @"heuriger"},
                            @{@"name": @"Himalayan/Nepalese", @"code": @"himalayan"},
                            @{@"name": @"Hong Kong Style Cafe", @"code": @"hkcafe"},
                            @{@"name": @"Hot Dogs", @"code": @"hotdog"},
                            @{@"name": @"Hot Pot", @"code": @"hotpot"},
                            @{@"name": @"Hungarian", @"code": @"hungarian"},
                            @{@"name": @"Iberian", @"code": @"iberian"},
                            @{@"name": @"Indian", @"code": @"indpak"},
                            @{@"name": @"Indonesian", @"code": @"indonesian"},
                            @{@"name": @"International", @"code": @"international"},
                            @{@"name": @"Irish", @"code": @"irish"},
                            @{@"name": @"Island Pub", @"code": @"island_pub"},
                            @{@"name": @"Israeli", @"code": @"israeli"},
                            @{@"name": @"Italian", @"code": @"italian"},
                            @{@"name": @"Japanese", @"code": @"japanese"},
                            @{@"name": @"Jewish", @"code": @"jewish"},
                            @{@"name": @"Kebab", @"code": @"kebab"},
                            @{@"name": @"Korean", @"code": @"korean"},
                            @{@"name": @"Kosher", @"code": @"kosher"},
                            @{@"name": @"Kurdish", @"code": @"kurdish"},
                            @{@"name": @"Laos", @"code": @"laos"},
                            @{@"name": @"Laotian", @"code": @"laotian"},
                            @{@"name": @"Latin American", @"code": @"latin"},
                            @{@"name": @"Live/Raw Food", @"code": @"raw_food"},
                            @{@"name": @"Lyonnais", @"code": @"lyonnais"},
                            @{@"name": @"Malaysian", @"code": @"malaysian"},
                            @{@"name": @"Meatballs", @"code": @"meatballs"},
                            @{@"name": @"Mediterranean", @"code": @"mediterranean"},
                            @{@"name": @"Mexican", @"code": @"mexican"},
                            @{@"name": @"Middle Eastern", @"code": @"mideastern"},
                            @{@"name": @"Milk Bars", @"code": @"milkbars"},
                            @{@"name": @"Modern Australian", @"code": @"modern_australian"},
                            @{@"name": @"Modern European", @"code": @"modern_european"},
                            @{@"name": @"Mongolian", @"code": @"mongolian"},
                            @{@"name": @"Moroccan", @"code": @"moroccan"},
                            @{@"name": @"New Zealand", @"code": @"newzealand"},
                            @{@"name": @"Night Food", @"code": @"nightfood"},
                            @{@"name": @"Norcinerie", @"code": @"norcinerie"},
                            @{@"name": @"Open Sandwiches", @"code": @"opensandwiches"},
                            @{@"name": @"Oriental", @"code": @"oriental"},
                            @{@"name": @"Pakistani", @"code": @"pakistani"},
                            @{@"name": @"Parent Cafes", @"code": @"eltern_cafes"},
                            @{@"name": @"Parma", @"code": @"parma"},
                            @{@"name": @"Persian/Iranian", @"code": @"persian"},
                            @{@"name": @"Peruvian", @"code": @"peruvian"},
                            @{@"name": @"Pita", @"code": @"pita"},
                            @{@"name": @"Pizza", @"code": @"pizza"},
                            @{@"name": @"Polish", @"code": @"polish"},
                            @{@"name": @"Portuguese", @"code": @"portuguese"},
                            @{@"name": @"Potatoes", @"code": @"potatoes"},
                            @{@"name": @"Poutineries", @"code": @"poutineries"},
                            @{@"name": @"Pub Food", @"code": @"pubfood"},
                            @{@"name": @"Rice", @"code": @"riceshop"},
                            @{@"name": @"Romanian", @"code": @"romanian"},
                            @{@"name": @"Rotisserie Chicken", @"code": @"rotisserie_chicken"},
                            @{@"name": @"Rumanian", @"code": @"rumanian"},
                            @{@"name": @"Russian", @"code": @"russian"},
                            @{@"name": @"Salad", @"code": @"salad"},
                            @{@"name": @"Sandwiches", @"code": @"sandwiches"},
                            @{@"name": @"Scandinavian", @"code": @"scandinavian"},
                            @{@"name": @"Scottish", @"code": @"scottish"},
                            @{@"name": @"Seafood", @"code": @"seafood"},
                            @{@"name": @"Serbo Croatian", @"code": @"serbocroatian"},
                            @{@"name": @"Signature Cuisine", @"code": @"signature_cuisine"},
                            @{@"name": @"Singaporean", @"code": @"singaporean"},
                            @{@"name": @"Slovakian", @"code": @"slovakian"},
                            @{@"name": @"Soul Food", @"code": @"soulfood"},
                            @{@"name": @"Soup", @"code": @"soup"},
                            @{@"name": @"Southern", @"code": @"southern"},
                            @{@"name": @"Spanish", @"code": @"spanish"},
                            @{@"name": @"Steakhouses", @"code": @"steak"},
                            @{@"name": @"Sushi Bars", @"code": @"sushi"},
                            @{@"name": @"Swabian", @"code": @"swabian"},
                            @{@"name": @"Swedish", @"code": @"swedish"},
                            @{@"name": @"Swiss Food", @"code": @"swissfood"},
                            @{@"name": @"Tabernas", @"code": @"tabernas"},
                            @{@"name": @"Taiwanese", @"code": @"taiwanese"},
                            @{@"name": @"Tapas Bars", @"code": @"tapas"},
                            @{@"name": @"Tapas/Small Plates", @"code": @"tapasmallplates"},
                            @{@"name": @"Tex-Mex", @"code": @"tex-mex"},
                            @{@"name": @"Thai", @"code": @"thai"},
                            @{@"name": @"Traditional Norwegian", @"code": @"norwegian"},
                            @{@"name": @"Traditional Swedish", @"code": @"traditional_swedish"},
                            @{@"name": @"Trattorie", @"code": @"trattorie"},
                            @{@"name": @"Turkish", @"code": @"turkish"},
                            @{@"name": @"Ukrainian", @"code": @"ukrainian"},
                            @{@"name": @"Uzbek", @"code": @"uzbek"},
                            @{@"name": @"Vegan", @"code": @"vegan"},
                            @{@"name": @"Vegetarian", @"code": @"vegetarian"},
                            @{@"name": @"Venison", @"code": @"venison"},
                            @{@"name": @"Vietnamese", @"code": @"vietnamese"},
                            @{@"name": @"Wok", @"code": @"wok"},
                            @{@"name": @"Wraps", @"code": @"wraps"},
                            @{@"name": @"Yugoslav", @"code": @"yugoslav"}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(onSearch)];
    self.title = @"Filters";
    _FilterTableview.delegate = self;
    _FilterTableview.dataSource = self;
    [self.FilterTableview registerNib:[UINib nibWithNibName:@"CategoriesTableViewCell" bundle:nil] forCellReuseIdentifier:@"CategoriesTableViewCell"];
    [self.FilterTableview registerNib:[UINib nibWithNibName:@"DropDownTableViewCell" bundle:nil] forCellReuseIdentifier:@"DropDownTableViewCell"];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{

    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
//    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
    v.backgroundView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    else if (section == 1)
        if (_IsViewAllDistances)
            return self.distances.count;
        else
            return 1;
//    else if (section == 2)
//        return 1;
    else
        if (_IsViewAllCategories)
            return self.categories.count;
        else
            return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2){
        if (!_IsViewAllCategories && indexPath.row == 4){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView.layer setBorderColor:[UIColor colorWithRed:0.53 green:0.48 blue:0.48 alpha:1.0].CGColor];
            cell.textLabel.textColor = [UIColor colorWithRed:0.53 green:0.48 blue:0.48 alpha:1.0];
            [cell.contentView.layer setBorderWidth:1.0f];
            cell.contentView.layer.cornerRadius = 3;
            cell.contentView.clipsToBounds = YES;
            cell.textLabel.text = @"See All";
            return cell;
        }else{
            CategoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoriesTableViewCell"];
            cell.delegate = self;
            cell.cellType = @"Categories";
            cell.categoryNameCell.text = self.categories[indexPath.row][@"name"];
            cell.on = [self.selectedCategories containsObject:self.categories[indexPath.row]];
            return cell;
        }
    }
    else if(indexPath.section == 0){
        CategoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoriesTableViewCell"];
        cell.delegate = self;
        cell.cellType = @"Deal";
        cell.categoryNameCell.text = @"Offering a Deal";
        cell.on = _isSelectedDeal;
        return cell;
    } else if(indexPath.section == 1){
        if (!_IsViewAllDistances){
            DropDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropDownTableViewCell"];
            cell.titleLabel.text = self.distances[_selectedDistanceIndex];
            cell.rightImageButton.transform = CGAffineTransformMakeRotation(M_PI_2);
            [cell.rightImageButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
            return cell;
        }else{
            DropDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropDownTableViewCell"];
            cell.titleLabel.text = self.distances[indexPath.row];
            cell.rightImageButton.transform = CGAffineTransformIdentity;
            if(indexPath.row == _selectedDistanceIndex)
                [cell.rightImageButton setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
            else
                [cell.rightImageButton setImage:[UIImage imageNamed:@"gray_tick"] forState:UIControlStateNormal];
            return cell;
        }
    }
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return @"Distance";
    else if (section == 2)
        return @"Category";
    else if (section == 3)
        return @"Category";
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section == 2) && !_IsViewAllCategories && indexPath.row == 4){
        _IsViewAllCategories = YES;
        [self.FilterTableview reloadData];
    }else if (indexPath.section == 1){
        if(!_IsViewAllDistances){
            _IsViewAllDistances = YES;
            [self.FilterTableview reloadData];
        }else {
            _IsViewAllDistances = NO;
            self.selectedDistanceIndex = (int)indexPath.row;
            [self.FilterTableview reloadData];
        }
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void) onCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) onSearch{
    [self.delegate settingsViewController:self didChangeFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) categoriesTableViewCell:(CategoriesTableViewCell *) tableViewCell didToggle:(BOOL) value{
    if([tableViewCell.cellType  isEqual: @"Categories"]){
        NSIndexPath *indexPath = [self.FilterTableview indexPathForCell:tableViewCell];
        if(value){
            [self.selectedCategories addObject:self.categories[indexPath.row]];
        }else{
            [self.selectedCategories removeObject:self.categories[indexPath.row]];
        }

    }else{
        if(value){
            _isSelectedDeal = YES;
        }else{
            _isSelectedDeal = NO;
        }
    }
}

@end
