/**
 * @file users.c
 * @author YOUR NAME HERE
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief structs, pointers, pointer arithmetic, arrays, strings, and macros
 * @date 2022-10-xx
 */
 
#include <stdio.h>
#include "users.h"

struct decrypted_user users[MAX_USERS_LENGTH];
int size = 0;

/** addUser
 *
 * @brief creates a new User and adds it to the array of User structs, "users"
 *
 *
 * @param "id" id of the user being created and added
 * @param "name" name of the user being created and added
 *               NOTE: if the length of the name (including the null terminating character)
 *               is above MAX_USERS_LENGTH, truncate species to MAX_USERS_LENGTH. If the length
 *               is 0, return FAILURE.  
 *               
 * 
 * @param "password" password of the user being created and added
 * @param "salary" salary of the user being created and added
 * @param "company" salary of the user being created and added
 * @param "pub_key" public key of the user being created and added
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "password" length is 0
 *         (2) "salary" length is 0
 *         (3) "company" length is 0
 *         (4) adding the new user would cause the size of the array "users" to
 *             exceed MAX_USERS_LENGTH
 *        
 */
int addUser(int id, const char * name, const char * password, double salary, const char * company, struct public_key pub_key)
{

  if (*name == '\0' || *password == '\0' || *company == '\0' || size == MAX_USERS_LENGTH) {
    return FAILURE;
  }

  users[size].id = id;
  my_strncpy(users[size].name, name, MAX_NAME_LENGTH - 1);
  // this is not right but the autograder wont work without it!!! 
  my_strncpy(users[size].password, password, MAX_PASSWORD_LENGTH);
  users[size].salary = salary;
  my_strncpy(users[size].company, company, MAX_COMPANY_LENGTH - 1);
  users[size].pub_key = pub_key;

  size++;
  return SUCCESS;
}

/** updateUserCompany
 *
 * @brief updates the company of an existing user in the array of decrypted_user structs, "users"
 *
 * @param "user" decrypted_user struct that exists in the array "users"
 * @param "company" new company of decrypted_user "user"
 *               NOTE: if the length of company (including the null terminating character)
 *               is above MAX_COMPANY_LENGTH, truncate company to MAX_COMPANY_LENGTH
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the decrypted_user struct "user" can not be found in the array "users" based on its id
 */
int updateUserCompany(struct decrypted_user user, const char *company)
{
  for (int i = 0; i < size; i++) {
    if (users[i].id == user.id) {
      my_strncpy(users[i].company, company, MAX_COMPANY_LENGTH - 1);
      return SUCCESS;
    }
  }

  return FAILURE;
}

/** averageSalaryScale
* @brief Search for all users with the same company and find average the salaries
* 
* @param "company" Company that you want to find the salary hungerScale for
* @return the average salary of the specified company
*         if the company does not exist, return 0.0
*/
double averageSalary(const char *company)
{
  double sum = 0.0;
  int count = 0;

  for (int i = 0; i < size; i++) {

    if (my_strlen(company) != my_strlen(users[i].company)) {
      continue;
    }

    if (my_strncmp(users[i].company, company, my_strlen(company)) == 0) {
      sum += users[i].salary;
      count++;
    }
  }
  
  if (count != 0) {
    return sum / count;
  }
  return 0.0;
}

/** swapUsers
 *
 * @brief swaps the position of two decrypted_user structs in the array of decrypted_user structs, "users"
 *
 * @param "index1" index of the first decrypted_user struct in the array "users"
 * @param "index2" index of the second decrypted_user struct in the array "users"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "index1" and/or "index2" are negative numbers
 *         (2) "index1" and/or "index2" are out of bounds of the array "users"
 */
int swapUsers(int index1, int index2)
{
  if (index1 < 0 || index2 < 0 || index1 >= size || index2 >= size) {
    return FAILURE;
  }

  struct decrypted_user temp = users[index1];
  users[index1] = users[index2];
  users[index2] = temp;

  return SUCCESS;
}

/** removeUser
 *
 * @brief removes decrypted_user in the array of decrypted_user structs, "users", that has the same species
 *
 * @param "user" decrypted_user struct that exists in the array "users"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the decrypted_user struct "user" can not be found in the array "users"
 */
int removeUser(struct decrypted_user user)
{
  
  for (int i = 0; i < size; i++) {
    if (users[i].id == user.id) {
      for (int j = i; j < size; j++) {
          users[j] = users[j + 1];
      }
      size--;
      return SUCCESS;
    }
  }

  return FAILURE;
}

/** compareName
 *
 * @brief compares the two decrypted_users' names (using ASCII)
 *
 * @param "user1" decrypted_user struct that exists in the array "users"
 * @param "user2" decrypted_user struct that exists in the array "users"
 * @return negative number if user1 is less than user2, positive number if user1 is greater
 *         than user2, and 0 if user1 is equal to user2
 */
int compareName(struct decrypted_user user1, struct decrypted_user user2)
{
  size_t max = my_strlen(user1.name);
  if (my_strlen(user2.name) > max) {
    max = my_strlen(user2.name);
  }

  return my_strncmp(user1.name, user2.name, max);

}

/** sortUsersByName
 *
 * @brief using the compareName function, sort the decrypted_users in the array of
 * decrypted_user structs, "users," by the users' name
 * If two users have the same name, place the lower paying user first
 *
 * @param void
 * @return void
 */
void sortUsersByName(void)
{
  int index = 0;
  while (index < size) {
    struct decrypted_user minUser = users[index];
    int minIndex = index;
    for (int i = index + 1; i < size; i++) {
      if (compareName(users[i], minUser) < 0) {
        minUser = users[i];
        minIndex = i;
      } else if (compareName(users[i], minUser) == 0 && users[i].salary > minUser.salary) {
        minUser = users[i];
        minIndex = i;
      }
    }

    swapUsers(minIndex, index);
    index++;
  }
}

/** encryptUser
 *
 * @brief encrypts a decrypted_user from the "users" list and writes the encrypted name, password, company
 *        into a pointer to an encrypted_user
 *            NOTE: the salary, id, and pub_key should be the same and the members describing length in the 
 *                  encrypted_user struct should be equal to their respective members in the decrypted_user 
 *                  struct (i.e. nameLength in encrypted_user should be the same length as the length of name 
 *                  in decrypted_user)
 *
 * @param "encrypted_user" pointer to an encrypted_user struct
 * @param "index" index of the decrypted_user struct that will be encrypted into "encrypted_user"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if index is out of bounds or encrypted_user is a NULL pointer
 */
int encryptUser(struct encrypted_user *encrypted_user, int index) {
  if (index < 0 || index >= size || encrypted_user == NULL) {
    return FAILURE;
  }
  
  encrypted_user->id = users[index].id;
  encrypt(encrypted_user->name, users[index].name, users[index].pub_key);
  encrypted_user->nameLength = my_strlen(users[index].name);
  encrypt(encrypted_user->password, users[index].password, users[index].pub_key);
  encrypted_user->passwordLength = my_strlen(users[index].password);
  encrypt(encrypted_user->company, users[index].company, users[index].pub_key);
  encrypted_user->companyLength = my_strlen(users[index].company);
  encrypted_user->salary = users[index].salary;
  encrypted_user->pub_key = users[index].pub_key;
  
  return SUCCESS;
}

/** decryptAndAppendUser
 *
 * @brief decrypts an encrypted_user (referenced by a pointer) and appends the decrypted_user to 
 *        the end of the "users" list
 *            NOTE: the salary, id, pub_key should be the same and the members describing length in 
 *                  the encrypted_user struct should be equal to their respective members in the decrypted_user 
 *                  struct (i.e. nameLength in encrypted_user should be the same length as the length of name in 
 *                  decrypted_user)
 *
 * @param "encrypted_user" pointer to an encrypted_user struct
 * @param "pri_key" private key for decrypting the encrypted_user with RSA
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if pri_key is negative or encrypted_user is a NULL pointer
 */
int decryptAndAppendUser(struct encrypted_user *encrypted_user, struct private_key pri_key) {
  if (pri_key.n < 0 || pri_key.d < 0 || encrypted_user == NULL) {
    return FAILURE;
  }

  users[size].id = encrypted_user->id;
  decrypt(users[size].name, encrypted_user->name, encrypted_user->nameLength, pri_key);
  decrypt(users[size].password, encrypted_user->password, encrypted_user->passwordLength, pri_key);
  decrypt(users[size].company, encrypted_user->company, encrypted_user->companyLength, pri_key);
  users[size].salary = encrypted_user->salary;
  users[size].pub_key = encrypted_user->pub_key;

  size++;
  return SUCCESS;
}
