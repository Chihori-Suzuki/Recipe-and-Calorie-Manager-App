/**
 * 709. To Lower Case
 * @param {string} s
 * @return {string}
 */
var toLowerCase = function (s) {
  let string = s;
  string = string.toLowerCase();
  console.log(string);
};

// toLowerCase("husf");

/**
 * 1480. Running Sum of 1d Array
 * @param {number[]} nums
 * @return {number[]}
 */
var runningSum = function (nums) {
  let answerNum = nums;
  for (let i = 1; i < nums.length; i++) {
    answerNum[i] = nums[i - 1] + nums[i];
  }

  return answerNum;
};

/**
 * check
 * 257. Binary Tree Paths
 * Definition for a binary tree node.
 * function TreeNode(val, left, right) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.left = (left===undefined ? null : left)
 *     this.right = (right===undefined ? null : right)
 * }
 */
/**
 * @param {TreeNode} root
 * @return {string[]}
 */

function TreeNode(val, left, right) {
  this.val = val === undefined ? 0 : val;
  this.left = left === undefined ? null : left;
  this.right = right === undefined ? null : right;
}

var root = [1, 2, 3, null, 5];

var binaryTreePaths = function (root) {
  var list = [];
  if (root != null) recursiveSearch(root, "", list);
};

function recursiveSearch(root, path, list) {
  if (root.left == null && root.right == null) {
    list.push(path + root.val);
    return;
  }
  if (root.left != null) {
    path = path + root.val + "->";
    recursiveSearch(root.left, path, list);
  }
  if (root.right != null) {
    path = path + root.val + "->";
    recursiveSearch(root.left, path, list);
  }
}

/**
 * 977. Squares of a Sorted Array
 * @param {number[]} nums
 * @return {number[]}
 */

const nums = [-4, -1, 0, 3, 10];
var sortedSquares = function (nums) {
  let answer = [];

  for (i in nums) {
    answer.push(nums[i] * nums[i]);
  }
  answer.sort(function (a, b) {
    if (a < b) return -1;
    if (a > b) return 1;
    return 0;
  });
  return answer;
};

// sortedSquares(nums);

/**
 * 104. Maximum Depth of Binary Tree
 * Definition for a binary tree node.
 * function TreeNode(val, left, right) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.left = (left===undefined ? null : left)
 *     this.right = (right===undefined ? null : right)
 * }
 */

/**
 * @param {TreeNode} root
 * @return {number}
 */
var maxDepth = function (root) {
  function dfs(root, height) {
    if (root == null) return height;
    return Math.max(dfs(root.left, height + 1), dfs(root.right, height + 1));
  }

  return dfs(root, 0);
};

/**
 * 929. Unique Email Addresses
 * @param {string[]} emails
 * @return {number}
 */
var numUniqueEmails = function (emails) {};
